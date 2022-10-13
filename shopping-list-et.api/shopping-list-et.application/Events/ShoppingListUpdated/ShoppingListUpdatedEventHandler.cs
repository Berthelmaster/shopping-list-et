using MediatR;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Logging;
using shopping_list_et.infrastructure.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.Events.ShoppingListUpdated
{
    public class ShoppingListUpdatedEventHandler : INotificationHandler<ShoppingListUpdatedEvent>
    {
        private readonly IHubContext<ShoppingListHub> hubContext;
        private readonly ILogger<ShoppingListUpdatedEventHandler> logger;

        public ShoppingListUpdatedEventHandler(IHubContext<ShoppingListHub> hubContext, ILogger<ShoppingListUpdatedEventHandler> logger)
        {
            this.hubContext = hubContext;
            this.logger = logger;
        }

        public async Task Handle(ShoppingListUpdatedEvent notification, CancellationToken cancellationToken)
        {
            logger.LogInformation("Sending event to update Shopping List");

            await hubContext.Clients.All.SendAsync("OnShoppingListChangedEvent", notification.ShoppingListId, cancellationToken);
        }
    }
}
