using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SportsLeagues.Interfaces;

namespace SportsLeagues.Models
{
  public class LeagueIndexModel
  {
    public ICollection<League> Leagues { get; set; }
  }

  public class LeagueDetailModel
  {
    public League League { get; set; }
  }

  public class SeasonModel
  {
    public Season Season { get; set; }
  }

  public class FixtureDetailModel
  {
    public Fixture Fixture { get; set; }
  }

}