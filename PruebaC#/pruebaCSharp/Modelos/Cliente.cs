using Newtonsoft.Json;

namespace pruebaCSharp.Modelos
{
    public class Cliente
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("primerNombre")]
        public string PrimerNombre { get; set; }

        [JsonProperty("segundoNombre")]
        public string SegundoNombre { get; set; }

        [JsonProperty("apellidos")]
        public string Apellidos { get; set; }

        [JsonProperty("identificacion")]
        public string Identificacion { get; set; }

        [JsonProperty("mail")]
        public string Mail { get; set; }

        [JsonProperty("estado")]
        public int Estado { get; set; }

        [JsonProperty("estadoDesc")]
        public string EstadoDesc { get; set; }
    }
}
