//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SportsLeagues.Interfaces
{
    using System;
    using System.Collections.Generic;
    
    public partial class Season
    {
        public Season()
        {
            this.Boxes = new HashSet<Box>();
        }
    
        public System.Guid Id { get; set; }
        public System.DateTime StartDate { get; set; }
        public System.DateTime EndDate { get; set; }
        public string Description { get; set; }
        public System.DateTime GeneratedDate { get; set; }
    
        public virtual ICollection<Box> Boxes { get; set; }
        public virtual LeagueConfig LeagueConfig { get; set; }
        public virtual League League { get; set; }
    }
}