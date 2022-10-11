using Microsoft.AspNetCore.SignalR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.infrastructure.SignalR
{
    public class ShoppingListHub : Hub
    {
        private readonly ILogger<ShoppingListHub> logger;

        public ShoppingListHub(ILogger<ShoppingListHub> logger)
        {
            this.logger = logger;
        }

        public override async Task OnConnectedAsync()
        {
            await base.OnConnectedAsync();

            logger.LogInformation("Device Conencted {deviceid}", Context.ConnectionId);

            await Clients.Caller.SendAsync("OnConnected");
        }

        public override Task OnDisconnectedAsync(Exception? exception)
        {
            logger.LogInformation("Device Disconnected");

            return base.OnDisconnectedAsync(exception);
        }
    }
}
