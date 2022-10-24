using MediatR;
using shopping_list_et.domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListCopy
{
    public class ShoppingListCopyCommand : IRequest<ShoppingList>
    {
        public int ShoppingListId { get; set; }
    }
}
