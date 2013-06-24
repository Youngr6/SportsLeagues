using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SportsLeagues.Interfaces;
using SportsLeagues.Models;

namespace SportsLeagues.Controllers
{
  public class HomeController : Controller
  {
    ILeagueManager leagueManager;

    public HomeController(ILeagueManager manager)
    {
      leagueManager = manager;
    }

    public ActionResult Index()
    {
      if (User.Identity.IsAuthenticated)
      {
        LeagueIndexModel model = new LeagueIndexModel();
        model.Username = User.Identity.Name;

        model.Leagues = leagueManager.GetLeagues(User.Identity.Name, null);

        model.Fixtures = leagueManager.GetFixtures(User.Identity.Name, User.Identity.Name);

        return View(model);
      }

      return View("IndexUnauth");
    }

    public ActionResult ViewSeason(Guid leagueId)
    {
      SeasonModel model = new SeasonModel();
      model.Season = leagueManager.GetCurrentSeason(User.Identity.Name, leagueId);

      return View(model);
 
    }

    public ActionResult About()
    {
      ViewBag.Message = "Your app description page.";

      return View();
    }

    public ActionResult Contact()
    {
      ViewBag.Message = "Your contact page.";

      return View();
    }
  }
}
