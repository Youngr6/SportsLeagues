using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SportsLeagues.Interfaces
{
  public class LeagueConfigDto
  {
    public Guid Id { get; set; }

    public int BoxSize { get; set; }

    public int Iterations { get; set; }

    public int MovementSize { get; set; }
  }
}
