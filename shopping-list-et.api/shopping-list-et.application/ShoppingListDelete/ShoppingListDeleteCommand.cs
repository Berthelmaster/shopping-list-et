using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListDelete
{
    public class ShoppingListDeleteCommand : IRequest<bool>
    {
        public int Id { get;set; }
    }
}
