using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportsLeagues.Interfaces
{
  public partial class Fixture
  {
    public override string ToString()
    {
      return string.Format("{0} {5} {1}({2}) vs {3}({4})", this.Date.ToShortDateString(), HomePlayers.First().FullName, HomePlayers.First().Seed,
        AwayPlayers.First().FullName, AwayPlayers.First().Seed, Court != null ? Court.Description : "(no court)");
    }
  }
}
