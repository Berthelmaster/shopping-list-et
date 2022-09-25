using MediatR;
using Microsoft.EntityFrameworkCore;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListItemCheck
{
    internal class ShoppingListItemCheckCommandHandler : IRequestHandler<ShoppingListItemCheckCommand, Item>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListItemCheckCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<Item> Handle(ShoppingListItemCheckCommand request, CancellationToken cancellationToken)
        {
            var item = await context.Items
                .Where(x => x.Id == request.ItemId)
                .FirstOrDefaultAsync(cancellationToken);

            if (item is null)
                throw new ArgumentNullException(nameof(item));

            item.Checked = request.isChecked;

            await context.SaveChangesAsync(cancellationToken);

            return item;
        }
    }
}
