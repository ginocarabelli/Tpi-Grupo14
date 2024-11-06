using CineAPI.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CineAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConsultasController : ControllerBase
    {
        private ConsultasRepositories _repo;
        public ConsultasController(ConsultasRepositories repo)
        {
            _repo = repo;
        }

        [HttpGet("/1/{puntuacion}")]
        public IActionResult Consulta1(string puntuacion)
        {
            decimal puntuacionFormateada = Convert.ToDecimal(puntuacion);
            return Ok(_repo.Consulta01(puntuacionFormateada));
        }
        [HttpGet("/2")]
        public IActionResult Consulta2()
        {
            return Ok(_repo.Consulta02());
        }
        [HttpGet("/3")]
        public IActionResult Consulta3()
        {
            return Ok(_repo.Consulta03());
        }
        [HttpGet("/4")]
        public IActionResult Consulta4()
        {
            return Ok(_repo.Consulta04());
        }
        [HttpGet("/5")]
        public IActionResult Consulta5()
        {
            return Ok(_repo.Consulta05());
        }
        [HttpGet("/6")]
        public IActionResult Consulta6()
        {
            return Ok(_repo.Consulta06());
        }
        [HttpGet("/7")]
        public IActionResult Consulta7()
        {
            return Ok(_repo.Consulta07());
        }
        [HttpGet("/8")]
        public IActionResult Consulta8()
        {
            return Ok(_repo.Consulta08());
        }
    }
}
