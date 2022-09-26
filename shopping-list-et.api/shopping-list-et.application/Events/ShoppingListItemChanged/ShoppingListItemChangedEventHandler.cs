using MediatR;
using Microsoft.AspNetCore.SignalR;
using Microsoft.Extensions.Logging;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.Events.ShoppingListItemChanged
{
    public class ShoppingListItemChangedEventHandler : INotificationHandler<ShoppingListItemChangedEvent>
    {
        private readonly IHubContext<ShoppingListHub> hubcontext;
        private readonly ILogger<ShoppingListItemChangedEventHandler> logger;

        public ShoppingListItemChangedEventHandler(IHubContext<ShoppingListHub> hubcontext, ILogger<ShoppingListItemChangedEventHandler> logger)
        {
            this.hubcontext = hubcontext;
            this.logger = logger;
        }
        public async Task Handle(ShoppingListItemChangedEvent notification, CancellationToken cancellationToken)
        {
            logger.LogInformation($"OnItemChangedEvent: Adjusting shoppinglist with Id {notification.ShoppingListId}");

            await hubcontext.Clients.All.SendAsync("OnItemChangedEvent", notification.ShoppingListId, cancellationToken);
        }
    }
}
