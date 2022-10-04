using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListModifyName
{
    public class ShoppingListModifyNameCommand
    {
        public int ShoppingListId { get; set; }
        public string? ShoppingListName { get; set; }
    }
}
