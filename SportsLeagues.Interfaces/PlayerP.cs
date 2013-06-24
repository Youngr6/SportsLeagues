using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportsLeagues.Interfaces
{
  public partial class Player
  {
    public string FullName { get { return (FirstName + " " + LastName).Trim(); } }
  }
}
