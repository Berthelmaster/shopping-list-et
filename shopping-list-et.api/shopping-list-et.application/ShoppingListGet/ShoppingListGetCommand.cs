using MediatR;
using shopping_list_et.domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListGet
{
    public class ShoppingListGetCommand : IRequest<ShoppingList>
    {
        public int ShoppingListId { get; set; }
    }
}
