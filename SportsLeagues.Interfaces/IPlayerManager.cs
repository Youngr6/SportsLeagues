using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportsLeagues.Interfaces
{
  public interface IPlayerManager
  {
    Player AddPlayer(string username, string firstName, string lastName, string emailAddress, string userName, string phoneNumber, string mobileNumber, int seed);

    Player[] GetPlayers(string username);

    Player LoadPlayer(string username, Guid playerId);

  }
}
