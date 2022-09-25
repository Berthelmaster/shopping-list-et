using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.Events.ShoppingListItemChanged
{
    public class ShoppingListItemChangedEventHandler : INotificationHandler<ShoppingListItemChangedEvent>
    {
        public Task Handle(ShoppingListItemChangedEvent notification, CancellationToken cancellationToken)
        {
            Console.WriteLine($"ShoppingList with id {notification.ShoppingListId} changed item with Id {notification.ItemId}");

            return Task.CompletedTask;
        }
    }
}
