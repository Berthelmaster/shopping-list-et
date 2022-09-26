// See https://aka.ms/new-console-template for more information
using Microsoft.AspNetCore.SignalR.Client;


Console.WriteLine("Hello, World!");

const string url = "ws://localhost:5062/signalr/hub";

Thread.Sleep(10000);

var client = new HubConnectionBuilder()
    .WithUrl(url)
    .Build();


client.On<int>("OnItemChangedEvent", (id) =>
{
    Console.WriteLine($"Item with id {id} changed");
});

client.On("OnShoppingListChangedEvent", () =>
{
    Console.WriteLine("Received event to update item list");
});

await client.StartAsync();


Console.WriteLine(client.ConnectionId);

Console.Read();
