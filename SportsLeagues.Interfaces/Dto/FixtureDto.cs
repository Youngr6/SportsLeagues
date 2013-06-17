using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SportsLeagues.Interfaces
{
  public class FixtureDto
  {
    public Guid Id { get; set; }

    public string Description { get; set; }

    public DateTime Date { get; set; }

    public int HomeScore { get; set; }

    public int AwayScore { get; set; }

    public string Winner { get; set; }

    public PlayerDto[] AwayPlayers { get; set; }

    public PlayerDto[] HomePlayers { get; set; }
  }
}
