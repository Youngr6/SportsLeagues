using System;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SportsLeagues.Interfaces;
using SportsLeagues.Services;

namespace ServiceTests
{
  [TestClass]
  public class LeagueTests
  {
    [TestInitialize]
    public void Initialise()
    {
    }

    [TestCleanup]
    public void CleanUp()
    {
    }

    [TestMethod]
    public void CreateLeagueTest()
    {
      IPlayerManager pm = new PlayerManager();
      pm.AddPlayer("youngr6", "Dave", "Robb", "davidrobb.comsci.co.uk", null, "01425 477912", null);
      pm.AddPlayer("youngr6", "John", "Driscoll", "driscollj@waitrose.com", null, null, "07881 848846");
      pm.AddPlayer("youngr6", "Dan", "Mason", "damson@arrowuk.com", null, null, "07831 316891");
      pm.AddPlayer("youngr6", "Nic", "Lewis", "nic@pdq-airspares.co.uk", null, null, "07767 297200");
      pm.AddPlayer("youngr6", "Dave","Spencer", "dsone@hotmail.co.uk", null, null, "07813 646630");
      pm.AddPlayer("youngr6", "Liam", "Alldridge", "paul@avonserve.com", null, "01425 489509", "07925 481681");

      pm.AddPlayer("youngr6", "Adam", "Alldridge", "paul@avonserve.com", null, "01425 489509", "07925 481681");
      pm.AddPlayer("youngr6", "James","Laird", "laird112@msn.com", null, null, "0791 8153582");
      pm.AddPlayer("youngr6", "Clive","Simpkins", "clive.simpkins@virginmedia.com", null, null, "0790 1512637");
      pm.AddPlayer("youngr6", "Rob","Mears", "rmearsmulberry@aol.com",null, null, "07801 192503");
      pm.AddPlayer("youngr6", "Mark","Empson", "empsonm@fsmail.net", null, null, "07833 588569");
      pm.AddPlayer("youngr6", "Russell","Young", "russell.young@bluepony.co.uk", "youngr6", "01425 657951", "07713 575975");

      pm.AddPlayer("youngr6", "Simon", "Lillington", "slillington@college-chambers.co.uk", null, null, "07831 381129");
      pm.AddPlayer("youngr6", "Andy","Scammell", "andy.scam@hotmail.co.uk", null, "02380 482543", null);
      pm.AddPlayer("youngr6", "Graham", "Filmer", "graham1801@sky.com", null, null, "07766 704708");
      pm.AddPlayer("youngr6", "Richard", "Schofield", "richard.schofield@ymail.com", null, null, "07768 568256");
      pm.AddPlayer("youngr6", "Tim", "Salter","timsalter@btinternet.com", null, null, "07739 126743");
      pm.AddPlayer("youngr6", "Richard" ,"Jenner", "richard.jenner@openfield.co.uk",null, null, "07879 454472");

      ILeagueManager lm = new LeagueManagerService();
      League league = lm.CreateLeague("youngr6", "David Lloyd Squash", 6, 6, 2);
      Player[] players = pm.GetPlayers("youngr6");

      lm.AddPlayers("youngr6", league.Id, players.Select(p => p.Id).ToArray());
      lm.CalculateNewSeason("youngr6", league.Id, new DateTime(2013, 6, 17));

    }
  }
}
