using MediatR;
using Microsoft.AspNetCore.Mvc;
using shopping_list_et.application.Events.ShoppingListUpdated;
using shopping_list_et.application.ShoppingListCreate;
using shopping_list_et.application.ShoppingListDelete;
using shopping_list_et.application.ShoppingListGet;
using shopping_list_et.application.ShoppingListGetAll;
using shopping_list_et.application.ShoppingListModifyName;

namespace shopping_list_et.api.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class ShoppingListController : ControllerBase
    {
        private readonly IMediator mediator;

        public ShoppingListController(IMediator mediator)
        {
            this.mediator = mediator;
        }

        [HttpGet]
        public async Task<IActionResult> Get([FromQuery] int id, CancellationToken cancellationToken)
        {
            var command = new ShoppingListGetCommand()
            {
                ShoppingListId = id,
            };

            var response = await mediator.Send(command, cancellationToken);

            return Ok(response);
        }

        [HttpGet("include/deleted")]
        public async Task<IActionResult> GetIncludingDeleted(CancellationToken cancellationToken)
        {
            return Ok();
        }

        [HttpGet("all")]
        public async Task<IActionResult> GetAll(CancellationToken cancellationToken)
        {
            var command = new ShoppingListGetAllCommand()
            {

            };

            var response = await mediator.Send(command, cancellationToken);

            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> Create(CancellationToken cancellationToken)
        {
            var command = new ShoppingListCreateCommand()
            {

            };

            var response = await mediator.Send(command, cancellationToken);

            var @event = new ShoppingListUpdatedEvent()
            {

            };

            await mediator.Publish(@event, cancellationToken);

            return Ok(response);
        }

        [HttpPut]
        public async Task<IActionResult> ModifyName([FromQuery] int shoppingListId, [FromQuery] string newName, CancellationToken cancellationToken)
        {
            var command = new ShoppingListModifyNameCommand()
            {
                ShoppingListId = shoppingListId,
                ShoppingListName = newName
            };


            var response = await mediator.Send(command, cancellationToken);
           
            var @event = new ShoppingListUpdatedEvent()
            {

            };

            await mediator.Publish(@event, cancellationToken);

            return Ok();
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(int id, CancellationToken cancellationToken)
        {
            var command = new ShoppingListDeleteCommand()
            {
                Id = id
            };

            var response = await mediator.Send(command, cancellationToken);

            if (response)
            {
                var @event = new ShoppingListUpdatedEvent()
                {

                };

                await mediator.Publish(@event, cancellationToken);

                return Ok();
            }

            return BadRequest();
        }
    }
}
