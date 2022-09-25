using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.Events.ShoppingListItemDelete
{
    public class ShoppingListItemDeleteEventHandler : INotificationHandler<ShoppingListItemDeleteEvent>
    {
        public Task Handle(ShoppingListItemDeleteEvent notification, CancellationToken cancellationToken)
        {
            Console.WriteLine($"Should delete item with id {notification.ItemId} for shoppinglist id: {notification.ShoppingListId}");

            return Task.CompletedTask;
        }
    }
}
