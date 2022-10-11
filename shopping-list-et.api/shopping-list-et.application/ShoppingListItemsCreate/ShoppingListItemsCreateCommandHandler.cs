using MediatR;
using Microsoft.EntityFrameworkCore;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListItemCreate
{
    public class ShoppingListItemsCreateCommandHandler : IRequestHandler<ShoppingListItemsCreateCommand, List<Item>>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListItemsCreateCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<List<Item>> Handle(ShoppingListItemsCreateCommand request, CancellationToken cancellationToken)
        {
            var newItems = new List<Item>();

            if (request.Texts is null || request.Texts.Count == 0)
                throw new ArgumentNullException(nameof(request.Texts));

            foreach (var text in request.Texts)
            {
                newItems.Add(new Item()
                {
                    Text = text,
                    CreatedAt = DateTime.UtcNow,
                    Checked = false,
                    ShoppingListId = request.ShoppingListId
                });
            }

            await context.Items.AddRangeAsync(newItems);

            await context.SaveChangesAsync(cancellationToken);

            return newItems;
        }
    }
}
