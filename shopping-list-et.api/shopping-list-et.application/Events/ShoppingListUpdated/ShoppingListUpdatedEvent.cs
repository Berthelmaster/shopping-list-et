using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.Events.ShoppingListUpdated
{
    public class ShoppingListUpdatedEvent : INotification
    {
        public int ShoppingListId { get; set; }

        public ShoppingListUpdatedEvent(int shoppingListId)
        {
            ShoppingListId = shoppingListId;
        }
    }
}
