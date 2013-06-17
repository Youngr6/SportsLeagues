using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportsLeagues.Interfaces
{
  public interface IPlayerManager
  {
    Player AddPlayer(string username, string firstName, string lastName, string userName, string emailAddress, string phoneNumber, string mobileNumber);

    Player[] GetPlayers(string username);
  }
}
