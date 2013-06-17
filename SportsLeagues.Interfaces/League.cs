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
    
    public partial class League
    {
        public League()
        {
            this.Seasons = new HashSet<Season>();
            this.Players = new HashSet<Player>();
        }
    
        public System.Guid Id { get; set; }
        public string Name { get; set; }
    
        public virtual LeagueConfig LeagueConfig { get; set; }
        public virtual ICollection<Season> Seasons { get; set; }
        public virtual ICollection<Player> Players { get; set; }
    }
}