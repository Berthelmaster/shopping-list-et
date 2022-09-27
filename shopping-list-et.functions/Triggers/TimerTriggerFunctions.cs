using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using shopping_list_et.infrastructure.Context;

namespace shopping_list_et.functions.Triggers
{
    public class TimerTriggerFunctions
    {
        private readonly ApplicationDbContext context;

        public TimerTriggerFunctions(ApplicationDbContext context)
        {
            this.context = context;
        }

        [FunctionName("CheckExpiredShoppingLists")]
        public async Task CheckExpiredShoppingLists([TimerTrigger("0 */1 * * * *")] TimerInfo timer, ILogger log, CancellationToken cancellationToken)
        {
            if (timer.IsPastDue)
                return;

            var shoppingLists = await context.ShoppingLists.ToListAsync(cancellationToken);

            foreach (var shoppinglist in shoppingLists)
            {
                if (shoppinglist.UpdatedAt <= DateTime.UtcNow - TimeSpan.FromMinutes(15))
                    shoppinglist.Active = false;
            }

            await context.SaveChangesAsync(cancellationToken);

            log.LogInformation($"C# Timer trigger function executed at: {DateTime.UtcNow}");
        }

        [FunctionName("DeleteExpiredShoppingLists")]
        public async Task DeleteExpiredShoppingLists([TimerTrigger("0 */60 * * * *")] TimerInfo timer, ILogger log, CancellationToken cancellationToken)
        {
            if (timer.IsPastDue)
                return;

            var shoppingLists = await context.ShoppingLists.ToListAsync(cancellationToken);

            foreach (var shoppinglist in shoppingLists)
            {
                if (shoppinglist.UpdatedAt <= DateTime.UtcNow - TimeSpan.FromDays(30))
                    context.ShoppingLists.Remove(shoppinglist);
            }

            await context.SaveChangesAsync(cancellationToken);

            log.LogInformation($"C# Timer trigger function executed at: {DateTime.UtcNow}");
        }
    }
}
