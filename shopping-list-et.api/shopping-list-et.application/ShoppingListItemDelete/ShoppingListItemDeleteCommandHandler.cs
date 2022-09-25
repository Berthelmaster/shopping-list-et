using MediatR;
using Microsoft.EntityFrameworkCore;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListItemDelete
{
    public class ShoppingListItemDeleteCommandHandler : IRequestHandler<ShoppingListItemDeleteCommand, Item>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListItemDeleteCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<Item> Handle(ShoppingListItemDeleteCommand request, CancellationToken cancellationToken)
        {
            var item = await context.Items.Where(x => x.Id == request.ItemId).FirstOrDefaultAsync();

            if (item is null)
                throw new ArgumentNullException(nameof(item));

            context.Remove(item);

            await context.SaveChangesAsync(cancellationToken);

            return item;
        }
    }
}
