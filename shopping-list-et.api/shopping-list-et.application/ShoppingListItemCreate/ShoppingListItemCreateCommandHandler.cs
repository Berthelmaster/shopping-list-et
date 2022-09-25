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
    public class ShoppingListItemCreateCommandHandler : IRequestHandler<ShoppingListItemCreateCommand, Item>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListItemCreateCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<Item> Handle(ShoppingListItemCreateCommand request, CancellationToken cancellationToken)
        {
            var item = new Item()
            {
                Text = request.Text,
                CreatedAt = DateTime.UtcNow,
                Checked = false,
                ShoppingListId = request.ShoppingListId
            };

            await context.Items.AddAsync(item);

            await context.SaveChangesAsync(cancellationToken);

            return item;
        }
    }
}
