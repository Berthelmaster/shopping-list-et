using MediatR;
using Microsoft.EntityFrameworkCore;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListGet
{
    public class ShoppingListGetCommandHandler : IRequestHandler<ShoppingListGetCommand, ShoppingList>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListGetCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<ShoppingList> Handle(ShoppingListGetCommand request, CancellationToken cancellationToken)
        {
            var shoppingList = await context.ShoppingLists
                .Where(x => x.Id == request.ShoppingListId)
                .Include(x => x.Items)
                .FirstOrDefaultAsync();

            if (shoppingList is null)
                throw new ArgumentNullException(nameof(shoppingList));

            shoppingList.UpdatedAt = DateTime.UtcNow;

            await context.SaveChangesAsync(cancellationToken);

            return shoppingList;
        }
    }
}
