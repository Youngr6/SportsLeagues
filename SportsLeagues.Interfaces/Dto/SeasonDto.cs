using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SportsLeagues.Interfaces
{
  public class SeasonDto
  {
    public Guid Id { get; set; }

    public string Description { get; set; }

    public DateTime GeneratedDate { get; set; }

    public DateTime StartDate { get; set; }

    public DateTime EndDate { get; set; }
  }
}
