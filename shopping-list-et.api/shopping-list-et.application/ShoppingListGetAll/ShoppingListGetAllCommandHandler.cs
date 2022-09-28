using MediatR;
using Microsoft.EntityFrameworkCore;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListGetAll
{
    internal class ShoppingListGetAllCommandHandler : IRequestHandler<ShoppingListGetAllCommand, List<ShoppingList>>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListGetAllCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<List<ShoppingList>> Handle(ShoppingListGetAllCommand request, CancellationToken cancellationToken)
        {
            var shoppingLists = await context.ShoppingLists
                .Include(x => x.Items)
                .AsNoTracking()
                .ToListAsync(cancellationToken);

            return shoppingLists;
        }
    }
}
