using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SportsLeagues.Interfaces
{
  public class PlayerDto
  {
    public Guid Id { get; set; }

    public string FirstName { get; set; }

    public string LastName{ get; set; }

    public string UserName { get; set; }

    ContactDetailDto[] ContactDetails { get; set; }
  }
}
