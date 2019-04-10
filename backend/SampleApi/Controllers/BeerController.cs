﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using SampleApi.DAL;
using SampleApi.Models;

namespace SampleApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BeerController : ControllerBase
    {
        private IBeer beerDao;
        private IFavoriteDAO favoriteDAO;

        public BeerController(IBeer beerDao, IFavoriteDAO favoriteDAO)
        {
            this.beerDao = beerDao;
            this.favoriteDAO = favoriteDAO;
        }

        [HttpGet]
        [Route("{name}/{styleId}")]
        public ActionResult<List<Beer>> GetBeers([FromQuery]string name,[FromQuery]int styleId)
        {
            IList<Beer> beers = beerDao.GetBeers(name, styleId);
            return Ok(beers);
        }

        [HttpGet]
        [Route("{id}")]
        public ActionResult<Beer> GetBeer([FromQuery]int id)
        {
            Beer beer = beerDao.GetByBeerId(id);
            return Ok(beer);
        }

        [HttpPost]
        [Authorize]
        [Route("{id}/like")]
        public ActionResult FavoriteBeer([FromQuery]int beerId)
        {
            this.favoriteDAO.AddFavorite(base.User.Identity.Name.ToString(), beerId);

            return Ok();
        }

        [HttpDelete]
        [Authorize]
        [Route("{id}/like")]
        public ActionResult RemoveFavorite([FromQuery]int beerId)
        {
            this.favoriteDAO.RemoveFavorite(base.User.Identity.Name.ToString(), beerId);

            return Ok();
        }
    }
}