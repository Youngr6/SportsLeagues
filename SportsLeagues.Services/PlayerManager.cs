using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SportsLeagues.Interfaces;

namespace SportsLeagues.Services
{
  public class PlayerManager : IPlayerManager
  {
    public Player AddPlayer(string username, string firstName, string lastName, string userName, string emailAddress, string phoneNumber, string mobileNumber)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        try
        {
          Player player = new Player() { FirstName = firstName, LastName = lastName, Id = Guid.NewGuid(), Username = username };
          if (!string.IsNullOrEmpty(emailAddress))
            player.ContactDetails.Add(new ContactDetail() { Id = Guid.NewGuid(), ContactType = ContactTypeEnum.EMailAddress, ContactValue = emailAddress });
          if (!string.IsNullOrEmpty(phoneNumber))
            player.ContactDetails.Add(new ContactDetail() { Id = Guid.NewGuid(), ContactType = ContactTypeEnum.Phone, ContactValue = phoneNumber });
          if (!string.IsNullOrEmpty(mobileNumber))
            player.ContactDetails.Add(new ContactDetail() { Id = Guid.NewGuid(), ContactType = ContactTypeEnum.Mobile, ContactValue = mobileNumber });

          context.Players.Add(player);
          context.SaveChanges();
          return player;
        }
        catch (DbEntityValidationException ex)
        {
          string error = ex.EntityValidationErrors.First().ToString();
          throw new Exception(error, ex);
        }
      }
    }

    Player[] IPlayerManager.GetPlayers(string username)
    {
      using (SportsLeaguesEntities context = new SportsLeaguesEntities())
      {
        return context.Players.ToArray();
      }
    }
  }
}
