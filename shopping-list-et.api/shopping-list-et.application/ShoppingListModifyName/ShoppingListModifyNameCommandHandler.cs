using MediatR;
using shopping_list_et.infrastructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace shopping_list_et.application.ShoppingListModifyName
{
    public class ShoppingListModifyNameCommandHandler : IRequestHandler<ShoppingListModifyNameCommand>
    {
        private readonly ApplicationDbContext context;

        public ShoppingListModifyNameCommandHandler(ApplicationDbContext context)
        {
            this.context = context;
        }

        public async Task<Unit> Handle(ShoppingListModifyNameCommand request, CancellationToken cancellationToken)
        {
            var shoppingList = await context.ShoppingLists.FindAsync(request.ShoppingListId);

            if (shoppingList is null)
                throw new ArgumentNullException(nameof(shoppingList));

            shoppingList.Name = request.ShoppingListName;

            await context.SaveChangesAsync();

            return new Unit();
        }
    }
}
