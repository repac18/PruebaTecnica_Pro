using Microsoft.AspNetCore.Mvc;
using PromericaPrueba.Conector;

namespace PromericaPrueba.Controllers
{
    public class DatosController : Controller
    {
        private readonly ILogger<DatosController> _logger;

        public DatosController(ILogger<DatosController> logger)
        {
            _logger = logger;
        }
        public RepoConector repoConector = new();
        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }


        [HttpGet]
        public ActionResult Get(string dato)
        {
            var affect = repoConector.Filas($"select *  from DatosManipular where nombre ='{dato}'");
            return Ok(affect);
        }

        [HttpGet]
        public ActionResult GetDataSet(string dato)
        {

            var result = repoConector.ObtenerDatos(dato).Tables[0];
            return Ok(new { filas = repoConector.Filas(dato), DataSet =dato }); ;
        }

        [HttpPost,ValidateAntiForgeryToken]
        public ActionResult Create(string dato)
        {
            var affect = repoConector.Filas($"insert into DatosManipular(Nombre) values('{dato}')");
            return Ok(affect);
        }

        [HttpPost,ValidateAntiForgeryToken]
        public ActionResult Update(string datoNuevo, string dato)
        {
            var affect = repoConector.Filas($"update DatosManipular set Nombre = '{datoNuevo}' where Nombre= '{dato}'");
            return Ok(affect);
        }

        [HttpPost,ValidateAntiForgeryToken] 
        public ActionResult Delete(string dato)
        {

            var affect = repoConector.Filas($"delete DatosManipular where Nombre = '{dato}'");
            return Ok(affect);
        }
    }
}
