using Microsoft.EntityFrameworkCore;
using shopping_list_et.infrastructure.Context;
using MediatR;
using shopping_list_et.application;
using shopping_list_et.infrastructure.SignalR;
using shopping_list_et.api;
using shopping_list_et.infrastructure.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers().AddNewtonsoftJson(options =>
    options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore
);

builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("Database"),
    b => b.MigrationsAssembly(typeof(ApplicationDbContext).Assembly.FullName)));

builder.Services.AddSignalR();

builder.Services.AddScoped<ShoppingListHub>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddApplicationServiceCollection();

var shoppingListConfiguration = new ShoppingListConfiguration();
builder.Configuration.Bind(shoppingListConfiguration);
builder.Services.AddSingleton(shoppingListConfiguration);

var textFromImageConfiguration = new TextFromImageConfiguration();
builder.Configuration.Bind(textFromImageConfiguration);
builder.Services.AddSingleton(textFromImageConfiguration);

builder.Services.AddScoped<TextFromImageService>();

var devCorsPolicy = "devCorsPolicy";
builder.Services.AddCors(options =>
{
    options.AddPolicy(devCorsPolicy, builder => {
        //builder.WithOrigins("http://localhost:800").AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
        builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
        //builder.SetIsOriginAllowed(origin => new Uri(origin).Host == "localhost");
        //builder.SetIsOriginAllowed(origin => true);
    });
});


var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    await dataContext.Database.MigrateAsync();
}

// Configure the HTTP request pipeline.
app.UseSwagger();
app.UseSwaggerUI();


app.UseCors(devCorsPolicy);

app.UseWebSockets();

if(!app.Environment.IsDevelopment())
    app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();
app.MapHub<ShoppingListHub>("/signalr/hub");

app.Run();
