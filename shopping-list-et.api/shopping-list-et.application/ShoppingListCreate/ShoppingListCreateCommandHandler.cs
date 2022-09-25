using MediatR;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListCreate
{
    public class ShoppingListCreateCommandHandler : IRequestHandler<ShoppingListCreateCommand, ShoppingList>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListCreateCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<ShoppingList> Handle(ShoppingListCreateCommand request, CancellationToken cancellationToken)
        {
            var newShoppingList = new ShoppingList()
            {
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow,
                Active = true,
                Items = new List<Item>(0)
            };

            await context.ShoppingLists.AddAsync(newShoppingList, cancellationToken);

            await context.SaveChangesAsync(cancellationToken);

            return newShoppingList;
        }
    }
}
