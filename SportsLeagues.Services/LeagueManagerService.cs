using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using SportsLeagues.Interfaces;

namespace SportsLeagues.Services
{
  public class LeagueManagerService : ILeagueManager
  {
    public League CreateLeague(string username, string leagueName, int boxSize, int iterations, int movementSize)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        LeagueConfig config = new LeagueConfig() { Id = Guid.NewGuid(), BoxSize = boxSize, Iterations = iterations, MovementSize = movementSize };
        League league = new League() { Id = Guid.NewGuid(), Name = leagueName, LeagueConfig = config };

        context.LeagueConfigs.Add(config);
        context.Leagues.Add(league);

        context.SaveChanges();

        return league;
      }
    }

    public League[] GetLeagues(string username, string searchText = null)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        if(string.IsNullOrEmpty(searchText))
          return context.Leagues.Include("Players").Include("Seasons").OrderBy(l => l.Name).ToArray();
        return context.Leagues.Include("Players").Include("Seasons").Where(l => l.Name.ToUpper().Contains(searchText.ToUpper())).ToArray();
      }
    }

    public Season GetCurrentSeason(string username, Guid leagueId)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        DateTime today = DateTime.Now.Date;

        return context.Seasons
          .Include("League")
          .Include("Boxes")
          .Include("Boxes.Fixtures")
          .Include("Boxes.Fixtures.Court")
          .Include("LeagueConfig")
          .Include("LeagueConfig.Courts")
          .Include("League.Players").SingleOrDefault(s => s.StartDate <= today && s.EndDate >= today);

      }
    }


    public Season CalculateNewSeason(string username, Guid leagueId, DateTime startDate)
    {
      using (SportsLeaguesEntities entities = new SportsLeaguesEntities())
      {
        League league = entities.Leagues.Include("LeagueConfig")
          .Include("Players")
          .Include("LeagueConfig.Courts")
          .SingleOrDefault(l => l.Id == leagueId);

        if (league == null)
          throw new ArgumentOutOfRangeException("Could not find league with id " + leagueId.ToString());

        Season season = new Season()
        {
          Id = Guid.NewGuid(),
          LeagueConfig = new LeagueConfig() { Id = Guid.NewGuid(), BoxSize = league.LeagueConfig.BoxSize,
             Iterations = league.LeagueConfig.Iterations,
             MovementSize = league.LeagueConfig.MovementSize 
          },
          Description = startDate.Date.ToString(),
          GeneratedDate = DateTime.Now,
          StartDate = startDate,
          EndDate = startDate //todo - fix this
        };

        league.Seasons.Add(season);

        foreach (Court court in league.LeagueConfig.Courts)
          season.LeagueConfig.Courts.Add(new Court() { Id = Guid.NewGuid(), Description = court.Description, Sequence = court.Sequence });

        // get all the players to work out how many boxes we need
        Player[] players = league.Players.ToArray();

        // see how many boxes we need
        // if we dont know the box size, it can be calculated as number of courts * 2 (2 being number of players)...

        if(season.LeagueConfig.BoxSize == 0 && season.LeagueConfig.Courts.Count > 0)
          season.LeagueConfig.BoxSize = season.LeagueConfig.Courts.Count * 2;

        int numPlayers = players.Count();
        int numBoxes = numPlayers / season.LeagueConfig.BoxSize;
        if (((double)numPlayers / (double)season.LeagueConfig.BoxSize) != (double)numBoxes)
          numBoxes++;

        // how many iterations do we need? - each player has to play all the others in the box
        int numIterations = season.LeagueConfig.BoxSize - 1;

        int boxSize = season.LeagueConfig.BoxSize;

        // go through each box creating the fixtures
        for (int boxNumber = 0; boxNumber < numBoxes; boxNumber++)
        {

          // get the first boxsize players from the list
          int seedStart = 1 + (boxNumber * season.LeagueConfig.BoxSize);
          int seedEnd = seedStart + season.LeagueConfig.BoxSize - 1;

          Box box = new Box() { Id = Guid.NewGuid(), Number = boxNumber + 1 };
          season.Boxes.Add(box);

          Player[] boxPlayers = players.Where(p => p.Seed >= seedStart && p.Seed <= seedEnd).OrderBy(p => p.Seed).ToArray();

          // create a matrix of who plays who
          Fixture lastFixture = null;

          int sequence = 0;
          bool boxFull = false;

          // repeat for each iteration
          DateTime fixtureDate = startDate.Date;

          for (int iteration = 0; iteration < numIterations; iteration++)
          {
            Console.WriteLine("Iteration {0} - date {1}", iteration, fixtureDate.ToShortDateString());

            bool boxComplete = false;
            while (!boxComplete)
            {
              for (int sf = seedStart; sf <= seedEnd && !boxFull; sf++)
              {
                // if this player's already got a fixture in this box then we can stop

                if (box.Fixtures.FirstOrDefault(f => f.Date == fixtureDate &&
                  (f.AwayPlayers.Any(ap => ap.Seed == sf)
                  || f.HomePlayers.Any(hp => hp.Seed == sf))) != null)
                {
                  Console.WriteLine("This player's already playing");
                }
                else
                {
                  for (int si = seedStart; si <= seedEnd && !boxFull; si++)
                  {
                    Console.WriteLine("Looking at {0} vs {1}", sf, si);

                    // if we have the same players but in home vs away or away vs home configuration, then we might want to ignore it
                    Fixture existingFixture = box.Fixtures.FirstOrDefault(f =>
                      (f.AwayPlayers.Any(ap => ap.Seed == sf) && f.HomePlayers.Any(hp => hp.Seed == si))
                      || (f.AwayPlayers.Any(ap => ap.Seed == si) && f.HomePlayers.Any(hp => hp.Seed == sf)));

                    if (existingFixture != null)
                    {
                      Console.WriteLine("Same match already on: " + existingFixture.ToString());
                    }
                    else
                    {
                      // if either player has a fixture already on the same date, then they can't play it also.

                      existingFixture = box.Fixtures.FirstOrDefault(f => f.Date == fixtureDate &&
                        (f.AwayPlayers.Any(ap => ap.Seed == si)
                        || f.HomePlayers.Any(hp => hp.Seed == si)));
                    }

                    if (existingFixture != null)
                    {
                      Console.WriteLine("This player's already playing this date: " + existingFixture.ToString());
                    }

                    if (si == sf)
                      Console.WriteLine("Cant play self");

                    if (lastFixture != null && (lastFixture.HomePlayers.Any(hp => hp.Seed == sf) &&
                      lastFixture.AwayPlayers.Any(hp => hp.Seed == si)))
                    {
                      existingFixture = lastFixture;
                      Console.WriteLine("This is the one we just removed, so we wont add that again " + existingFixture.ToString());
                    }

                    if (existingFixture == null && si != sf)
                    {
                      Fixture fixture = new Fixture()
                      {
                        Id = Guid.NewGuid(),
                        Sequence = sequence,
                        Date = fixtureDate,
                        HomePlayers = new Player[] { boxPlayers.Single(p => p.Seed == sf) },
                        AwayPlayers = new Player[] { boxPlayers.Single(p => p.Seed == si) }
                      };
                      box.Fixtures.Add(fixture);
                      lastFixture = fixture;

                      Console.WriteLine("Added Fixture " + fixture.ToString());

                      sequence++;

                      if (sequence == boxSize / 2)
                      {
                        boxFull = true;
                        boxComplete = true;
                        Console.WriteLine("Box full");
                      }

                      break;
                    }
                  }
                }
              }

              if (!boxComplete)
              {
                Console.WriteLine("Box incomplete - removing last fixture and trying again (" + lastFixture.ToString()+")");
                box.Fixtures.Remove(lastFixture);
                sequence--;
              }

            }
            Console.WriteLine("--------- Date complete ------------");

            Court[] courts = season.LeagueConfig.Courts.OrderBy(c => c.Sequence).ToArray();
            int courtCount = 0;
            foreach (Fixture fixture in box.Fixtures.Where(f => f.Date == fixtureDate).OrderBy(f => f.Sequence))
            {
              fixture.Court = courts[courtCount++];
              Console.WriteLine(fixture.ToString());
            }

            boxFull = false;
            sequence = 0;

            if (season.EndDate < fixtureDate)
              season.EndDate = fixtureDate;

            fixtureDate = fixtureDate.AddDays(7);
          }

        }
        try
        {
          entities.SaveChanges();
        }
        catch (DbEntityValidationException ex)
        {
          throw new Exception(ex.EntityValidationErrors.First().ValidationErrors.First().ErrorMessage);
        }
        return season;
      }
    }

    public Court AddCourt(string username, string description, int sequence)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        Court court = new Court() { Id = Guid.NewGuid(), Description = description, Sequence = sequence };
        context.Courts.Add(court);
        context.SaveChanges();
        return court;
           
      }
    }


    public void AddCourt(string username, Guid leagueId, Guid courtId)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        League league = context.Leagues
          .Include("LeagueConfig")
          .Include("LeagueConfig.Courts")
          .SingleOrDefault(l => l.Id == leagueId);
        Court court = context.Courts.SingleOrDefault(p => p.Id == courtId);
        if (!league.LeagueConfig.Courts.Any(p => p.Id == courtId))
          league.LeagueConfig.Courts.Add(court);

        context.SaveChanges();
      }
    }

    public void AddPlayer(string username, Guid leagueId, Guid playerId)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        League league = context.Leagues.Include("Players").SingleOrDefault(l => l.Id == leagueId);
        Player player = context.Players.SingleOrDefault(p => p.Id == playerId);
        if (!league.Players.Any(p => p.Id == playerId))
          league.Players.Add(player);

        context.SaveChanges();
      }
    }

    /// <summary>
    /// removes a specific player from the league
    /// </summary>
    /// <param name="username"></param>
    /// <param name="leagueId"></param>
    /// <param name="playerId"></param>
    public void RemovePlayer(string username, Guid leagueId, Guid playerId)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        League league = context.Leagues.Include("Player").SingleOrDefault(l => l.Id == leagueId);
        league.Players.Remove(league.Players.Single(p => p.Id == playerId));
        context.SaveChanges();
      }
    }


    public void AddPlayers(string username, Guid leagueId, Guid[] playerIds)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        League league = context.Leagues.Include("Players").SingleOrDefault(l => l.Id == leagueId);
        foreach (Guid playerId in playerIds)
        {
          if (!league.Players.Any(p => p.Id == playerId))
            league.Players.Add(context.Players.SingleOrDefault(p => p.Id == playerId));
        }
        context.SaveChanges();
      }

    }


    public Player[] GetPlayers(string username, Guid leagueId)
    {
      throw new NotImplementedException();
    }
  }
}
