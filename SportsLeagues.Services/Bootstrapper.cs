﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using AutoMapper;
using SportsLeagues.Interfaces;

namespace SportsLeagues.Services
{
  internal class Bootstrapper
  {
    public void Initialise()
    {
      //Mapper.CreateMap<League, LeagueDto>();

      //Mapper.CreateMap<Season, SeasonDto>();

      //Mapper.CreateMap<LeagueConfig, LeagueConfigDto>();

      Mapper.AssertConfigurationIsValid();

    }
  }
}