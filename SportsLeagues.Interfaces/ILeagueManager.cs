using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SportsLeagues.Interfaces
{
  public interface ILeagueManager
  {
    /// <summary>
    /// Create a new league and leageConfig in one go
    /// </summary>
    /// <param name="username"></param>
    /// <param name="leagueName"></param>
    /// <param name="boxSize"></param>
    /// <param name="iterations"></param>
    /// <param name="movementSize"></param>
    /// <returns></returns>
    League CreateLeague(string username, string leagueName, int boxSize, int iterations, int movementSize);

    /// <summary>
    /// Return a list of all the leagues the user specified has access to
    /// </summary>
    /// <param name="username"></param>
    /// <param name="searchText"></param>
    /// <returns></returns>
    League[] GetLeagues(string username, string searchText);

    Season GetCurrentSeason(string username, Guid leagueId);

    Season CalculateNewSeason(string username, Guid leagueId, DateTime startDate);

    Court AddCourt(string username, string courtName, int sequence);

    void AddCourt(string username, Guid leagueId, Guid courtId);

    void AddPlayer(string username, Guid leagueId, Guid playerId);

    void AddPlayers(string username, Guid leagueId, Guid[] playerIds);

    void RemovePlayer(string username, Guid leagueId, Guid playerId);

    Player[] GetPlayers(string username, Guid leagueId);

  }
}
