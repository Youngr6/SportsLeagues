using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SportsLeagues.Interfaces
{
  public class ContactDetailDto
  {
    public Guid Id { get; set; }

    public string Description { get; set; }

    public string ContactType { get; set; }

    public string ContactValue { get; set; }
  }
}
