using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using pruebaCSharp.Modelos;
using pruebaCSharp.Servicios;

namespace pruebaCSharp.Controllers
{
    [ApiController]
    [Route("api/clientes")]
    public class ClientesController : ControllerBase
    {

        private readonly ILogger<ClientesController> _logger;
        private readonly DbSqlContext _dbContext;


        public ClientesController(ILogger<ClientesController> logger, DbSqlContext dbContext)
        {
            _logger = logger;
           _dbContext = dbContext;
        }

        [HttpPost("crear", Name = "Crear")]
        public async Task<IActionResult> Crear([FromBody] ClienteCrearSolicitud clienteCrearSolicitud)
        {
            try
            {
                string msgError = ValidarClienteCrearSolicitud(clienteCrearSolicitud);
                if (!string.IsNullOrEmpty(msgError))
                {
                    ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = msgError };
                    return BadRequest(respuestaErronea);
                }

                // Lógica para procesar el cliente y generar una respuesta exitosa
                var result = await _dbContext.Clientes
                    .FromSql($@"EXEC spCrearClientes 
                @primerNombre={clienteCrearSolicitud.PrimerNombre},
                @segundoNombre={clienteCrearSolicitud.SegundoNombre},
                @apellidos={clienteCrearSolicitud.Apellidos},
                @identificacion={clienteCrearSolicitud.Identificacion},
                @mail={clienteCrearSolicitud.Mail}")
                    .ToListAsync();

                // Obtenemos el primer valor resultante del SP
                var singleResult = result.SingleOrDefault();

                // Devolver Ok con la respuesta exitosa
                ClienteRespuestaExitosa respuestaExitosa = new() { ProcesoExitoso = true, Id = singleResult.Id };
                return Ok(respuestaExitosa);
            }
            catch (Exception ex)
            {
                // Manejo de errores
                ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = ex.Message };
                return BadRequest(respuestaErronea);
            }
        }


        [HttpGet("consultar", Name = "Consultar")]
        public async Task<IActionResult> Consultar([FromQuery] string identificacion = "")
        {
            try
            {
                // Lógica para consultar clientes
                List<Cliente> result;
                if(identificacion == "")
                {
                    result = await _dbContext.Clientes
                    .FromSql($@"EXEC spConsultarClientes")
                    .ToListAsync();
                }
                else
                {
                    result = await _dbContext.Clientes
                    .FromSql($@"EXEC spConsultarClientes 
                @identificacion={identificacion}")
                    .ToListAsync();
                }

                if(result.Count > 0)
                {
                    return Ok(result);
                }

                if(identificacion != "")
                {
                    ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = "No existe cliente con dicha identificacion" };
                    return BadRequest(respuestaErronea);
                }
                else
                {
                    ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = "No existen clientes registrados" };
                    return BadRequest(respuestaErronea);
                }               
            }            
             catch (Exception ex)
            {
                // Manejo de errores
                ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = ex.Message };
                return BadRequest(respuestaErronea);
            }
        }
        [HttpPut("anular", Name = "Anular")]
        public async Task<IActionResult> Anular([FromBody] ClienteAnularSolicitud clienteAnularSolicitud)
        {            
            try
            {
                // Lógica para procesar el id del cliente y eliminarlo logicamente
                var result = await _dbContext.Clientes
                    .FromSql($@"EXEC spAnularClientes 
                @clienteId={clienteAnularSolicitud.Id}")
                    .ToListAsync();

                if (result is null)
                {
                    ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = "Hubo un error en la ejecucion de la base de datos" };
                    return BadRequest(respuestaErronea);
                }

                var singleResult = result.SingleOrDefault();

                if (singleResult is null) {
                    ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = "Hubo un error en la ejecucion de la base de datos" };
                    return BadRequest(respuestaErronea);
                }

                if (singleResult.Id == -1)
                {
                    ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = "No existe ningun cliente con el ID ingresado" };
                    return BadRequest(respuestaErronea);
                }

                if (singleResult.Id == -2)
                {
                    ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = "El cliente ya se encuentra inactivo" };
                    return BadRequest(respuestaErronea);
                }

                ClienteRespuestaExitosa respuestaExitosa = new() { ProcesoExitoso = true, Id = singleResult.Id };
                return Ok(respuestaExitosa);

            }
            catch (Exception ex)
            {
                // Manejo de errores
                ClienteRespuestaErronea respuestaErronea = new() { ProcesoExitoso = false, Mensaje = ex.Message };
                return BadRequest(respuestaErronea);
            }
        }

        private string ValidarClienteCrearSolicitud(ClienteCrearSolicitud clienteCrearSolicitud)
        {
            if (clienteCrearSolicitud.PrimerNombre is null || clienteCrearSolicitud.PrimerNombre == "")
            {
                return $"El campo primer nombre es requerido";
            }
            else if (clienteCrearSolicitud.Apellidos is null || clienteCrearSolicitud.Apellidos == "")
            {
                return $"El campo apellidos es requerido";
            }
            else if (clienteCrearSolicitud.Identificacion is null || clienteCrearSolicitud.Identificacion == "")
            {
                return $"El campo identificacion es requerido";
            }
            else if (clienteCrearSolicitud.Mail is null || clienteCrearSolicitud.Mail == "")
            {
                return $"El campo mail es requerido";
            }

            return null;
        }
    }
}
