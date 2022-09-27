using MediatR;
using Microsoft.AspNetCore.Mvc;
using shopping_list_et.application.Events;
using shopping_list_et.application.Events.ShoppingListItemChanged;
using shopping_list_et.application.ShoppingListCreate;
using shopping_list_et.application.ShoppingListItemCheck;
using shopping_list_et.application.ShoppingListItemCreate;
using shopping_list_et.application.ShoppingListItemDelete;

namespace shopping_list_et.api.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class ShoppingListItemController : ControllerBase
    {
        private readonly IMediator mediator;

        public ShoppingListItemController(IMediator mediator)
        {
            this.mediator = mediator;
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromQuery] string text, [FromQuery] int shoppingListId, CancellationToken cancellationToken)
        {
            var command = new ShoppingListItemCreateCommand()
            {
                Text = text,
                ShoppingListId = shoppingListId
            };

            var response = await mediator.Send(command, cancellationToken);

            var @event = new ShoppingListItemChangedEvent()
            {
                ItemId = response.Id,
                ShoppingListId = response.ShoppingListId
            };

            await mediator.Publish(@event, cancellationToken);

            return Ok(response);
        }

        [HttpPut("check")]
        public async Task<IActionResult> Check([FromQuery] int ItemId, [FromQuery] bool isChecked, CancellationToken cancellationToken)
        {
            var command = new ShoppingListItemCheckCommand()
            {
                ItemId = ItemId,
                isChecked = isChecked
            };

            var response = await mediator.Send(command, cancellationToken);

            var @event = new ShoppingListItemChangedEvent()
            {
                ItemId = response.Id,
                ShoppingListId = response.ShoppingListId
            };

            await mediator.Publish(@event, cancellationToken);

            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete([FromQuery] int itemId, CancellationToken cancellationToken)
        {
            var command = new ShoppingListItemDeleteCommand()
            {
                ItemId = itemId
            };

            var response = await mediator.Send(command, cancellationToken);

            var @event = new ShoppingListItemChangedEvent()
            {
                ItemId = response.Id,
                ShoppingListId = response.ShoppingListId
            };

            await mediator.Publish(@event, cancellationToken);

            return Ok(response);
        }
    }
}
