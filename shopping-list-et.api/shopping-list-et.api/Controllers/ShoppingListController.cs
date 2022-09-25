using MediatR;
using Microsoft.AspNetCore.Mvc;
using shopping_list_et.application.ShoppingListCreate;
using shopping_list_et.application.ShoppingListDelete;
using shopping_list_et.application.ShoppingListGetAll;

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

        [HttpPost]
        public async Task<IActionResult> Create(CancellationToken cancellationToken)
        {
            var command = new ShoppingListCreateCommand()
            {

            };

            var response = await mediator.Send(command, cancellationToken);

            return Ok(response);
        }

        [HttpDelete]
        public async Task<IActionResult> Delete(int id, CancellationToken cancellationToken)
        {
            var command = new ShoppingListDeleteCommand()
            {
                Id = id
            };

            var response = await mediator.Send(command, cancellationToken);

            return response
                ? Ok() 
                : BadRequest();
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
    }
}
