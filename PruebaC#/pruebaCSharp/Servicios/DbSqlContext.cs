using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using pruebaCSharp.Modelos;

namespace pruebaCSharp.Servicios
{
    public class DbSqlContext : DbContext
    {
        public DbSqlContext(DbContextOptions<DbSqlContext> options) : base(options)
        {
        }

        // Agrega tus DbSet para cada entidad (en este caso, la entidad Cliente)
        public DbSet<Cliente> Clientes { get; set; }
    }

}
