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
        private readonly ApplicationDbContext context;

        public ShoppingListHub(ILogger<ShoppingListHub> logger, ApplicationDbContext context)
        {
            this.logger = logger;
            this.context = context;
        }

        /*
        public async Task OnItemChangedEvent(int shoppingListId, CancellationToken cancellationToken)
        {
            logger.LogInformation($"OnItemChangedEvent: Adjusting shoppinglist with Id {shoppingListId}");

            await Clients.All.SendAsync("OnItemChangedEvent", shoppingListId, cancellationToken);
        }

        public async Task OnShoppingListChangedEvent(CancellationToken cancellationToken)
        {
            logger.LogInformation($"OnShoppingListChangedEvent: Dispatch event to fetch updated shopping list");

            await Clients.All.SendAsync("OnShoppingListChangedEvent", cancellationToken);
        }
        */

        public override async Task OnConnectedAsync()
        {
            await base.OnConnectedAsync();
        }
    }
}
