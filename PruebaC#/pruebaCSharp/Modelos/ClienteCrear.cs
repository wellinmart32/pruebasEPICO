using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace pruebaCSharp.Modelos
{
    public class ClienteCrearSolicitud
    {
        //[Required(ErrorMessage = "El Primer Nombre es requerido.")]
        [JsonProperty("primerNombre")]
        public string PrimerNombre { get; set; }

        [JsonProperty("segundoNombre")]
        public string SegundoNombre { get; set; }

        //[Required(ErrorMessage = "Los Apellidos son requeridos.")]
        [JsonProperty("apellidos")]
        public string Apellidos { get; set; }

        //[Required(ErrorMessage = "La Identificación es requerida.")]
        [JsonProperty("identificacion")]
        public string Identificacion { get; set; }

        //[Required(ErrorMessage = "El Correo Electrónico es requerido.")]
        //[EmailAddress(ErrorMessage = "El formato del Correo Electrónico no es válido.")]
        [JsonProperty("mail")]
        public string Mail { get; set; }
    }

    public class ClienteRespuestaExitosa
    {
        public bool ProcesoExitoso { get; set; }
        public int Id { get; set; }
    }

    public class ClienteRespuestaErronea
    {
        public bool ProcesoExitoso { get; set; }
        public string Mensaje { get; set; }
    }

}
