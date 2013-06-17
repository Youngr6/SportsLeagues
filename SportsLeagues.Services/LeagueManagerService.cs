using System;
using System.Collections.Generic;
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

    public League[] GetLeagues(string username, string searchText)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        return context.Leagues.Where(l => l.Name.ToUpper().Contains(searchText.ToUpper())).ToArray();
      }
    }

    public Season GetCurrentSeason(string username, Guid leagueId)
    {
      throw new NotImplementedException();
    }


    public Season CalculateNewSeason(string username, Guid leagueId, DateTime startDate)
    {
      using (SportsLeaguesEntities entities = new SportsLeaguesEntities())
      {
        League league = entities.Leagues.Include("LeagueConfig").Include("Players").SingleOrDefault(l => l.Id == leagueId);
        if (league == null)
          throw new ArgumentOutOfRangeException("Could not find league with id " + leagueId.ToString());

        Season season = new Season()
        {
          Id = Guid.NewGuid(),
          LeagueConfig = league.LeagueConfig,
          GeneratedDate = DateTime.Now,
          StartDate = startDate
        };

        // get all the players to work out how many boxes we need

        Player[] players = league.Players.ToArray();

        // see how many boxes we need

        int numPlayers = players.Count();
        int numBoxes = numPlayers / season.LeagueConfig.BoxSize;
        if (((double)numPlayers / (double)season.LeagueConfig.BoxSize) != (double)numBoxes)
          numBoxes++;




        return season;
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
