using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SportsLeagues.Interfaces;
using SportsLeagues.Models;

namespace SportsLeagues.Controllers
{
    public class PlayerController : Controller
    {

      IPlayerManager playerManager;

      public PlayerController(IPlayerManager mgr)
      {
        playerManager = mgr;
      }

      public ActionResult Index()
      {
          return View();
      }

      public ActionResult Profile(Guid playerId)
      {
        ProfileModel model = new ProfileModel();
        model.Player = playerManager.LoadPlayer(User.Identity.Name, playerId);

        return View(model);
      }

      [HttpGet]
      public PartialViewResult ProfilePartial(Guid playerId)
      {
        ProfileModel model = new ProfileModel();

        if (playerId == Guid.Empty)
        {
          model.Player = new Player() { FirstName = "Russell", LastName = "Test", Username = "youngr6", ContactDetails = new ContactDetail[] { new ContactDetail() { ContactType = ContactTypeEnum.EMailAddress, ContactValue = "russell.young@bluepony.co.uk", Id = Guid.NewGuid() } } };
        }
        else model.Player = playerManager.LoadPlayer(User.Identity.Name, playerId);

        return PartialView(model) ;
      }

    }
}
