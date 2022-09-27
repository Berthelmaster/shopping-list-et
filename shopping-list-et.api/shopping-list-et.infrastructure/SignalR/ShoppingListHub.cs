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

        public override async Task OnConnectedAsync()
        {
            await base.OnConnectedAsync();
        }
    }
}
