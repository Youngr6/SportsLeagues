using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SportsLeagues.Controllers
{
    public class LeagueController : Controller
    {
        //
        // GET: /League/

        public ActionResult Index()
        {
            return View();
        }

    }
}
