using MediatR;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListDelete
{
    public class ShoppingListDeleteCommandHandler : IRequestHandler<ShoppingListDeleteCommand, bool>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListDeleteCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<bool> Handle(ShoppingListDeleteCommand request, CancellationToken cancellationToken)
        {
            var shoppingList = await context.ShoppingLists.FindAsync(request.Id);

            if (shoppingList is null)
                return false;

            context.ShoppingLists.Remove(shoppingList);

            var changeTracker = await context.SaveChangesAsync();

            return changeTracker > 0;
        }
    }
}
