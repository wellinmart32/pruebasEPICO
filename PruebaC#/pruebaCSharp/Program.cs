using Microsoft.AspNetCore.Localization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using pruebaCSharp.Servicios;

var builder = WebApplication.CreateBuilder(args);

// Configuración de la conexión a la base de datos
string connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

// Agregar servicios a la colección de servicios.
builder.Services.AddDbContext<DbSqlContext>(options => options.UseSqlServer(connectionString));

// Configuración de la cultura predeterminada
builder.Services.Configure<RequestLocalizationOptions>(options =>
{
    options.DefaultRequestCulture = new RequestCulture("en-US"); // Establece la cultura predeterminada
});

builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
