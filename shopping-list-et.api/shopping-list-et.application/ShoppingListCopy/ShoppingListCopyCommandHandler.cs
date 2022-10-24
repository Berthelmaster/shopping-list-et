using MediatR;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListCopy
{
    public class ShoppingListCopyCommandHandler : IRequestHandler<ShoppingListCopyCommand, ShoppingList>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListCopyCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }
        public async Task<ShoppingList> Handle(ShoppingListCopyCommand request, CancellationToken cancellationToken)
        {
            var shoppingList = await context.ShoppingLists.FindAsync(request.ShoppingListId, cancellationToken);

            var shoppingListCopy = new ShoppingList()
            {
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow,
                Active = true,
                Name = shoppingList?.Name,
                Items = null
            };

            await context.AddAsync(shoppingListCopy);

            await context.SaveChangesAsync();

            var shoppingListItemsCopy = new List<Item>();

            if (shoppingList?.Items != null)
            {
                foreach (var item in shoppingList.Items)
                {
                    var newItem = new Item()
                    {
                        Checked = item.Checked,
                        CreatedAt = DateTime.UtcNow,
                        ShoppingListId = shoppingListCopy.Id,
                        Text = item.Text,
                    };

                    shoppingListItemsCopy.Add(newItem);
                }
            }

            await context.AddAsync(shoppingListItemsCopy);

            await context.SaveChangesAsync();

            return shoppingListCopy;
        }
    }
}
