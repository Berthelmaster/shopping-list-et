using MediatR;
using Microsoft.AspNetCore.Mvc;
using shopping_list_et.application.Events.ShoppingListItemChanged;
using shopping_list_et.application.Events.ShoppingListUpdated;
using shopping_list_et.application.ShoppingListItemCreate;
using shopping_list_et.domain.Entities;
using shopping_list_et.infrastructure.Services;

namespace shopping_list_et.api.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class ImageTextRecognitionController : ControllerBase
    {
        private readonly TextFromImageService textFromImageService;
        private readonly IMediator mediator;

        public ImageTextRecognitionController(TextFromImageService textFromImageService, IMediator mediator)
        {
            this.textFromImageService = textFromImageService;
            this.mediator = mediator;
        }

        [HttpPost]
        public async Task<IActionResult> Upload([FromQuery] int shoppingListId, IFormFile file, CancellationToken cancellationToken)
        {
            using var fileStream = file.OpenReadStream();
            
            var texts = await textFromImageService.GetText(fileStream, cancellationToken);

            var command = new ShoppingListItemsCreateCommand()
            {
                Texts = texts.ToList(),
                ShoppingListId = shoppingListId
            };

            var items = await mediator.Send(command, cancellationToken);

            var @event = new ShoppingListItemChangedEvent()
            {
                ItemId = items.FirstOrDefault()?.Id,
                ShoppingListId = items.FirstOrDefault()?.ShoppingListId
            };

            await mediator.Publish(@event, cancellationToken);

            var @eventLists = new ShoppingListUpdatedEvent(shoppingListId)
            {

            };

            await mediator.Publish(@eventLists, cancellationToken);

            return Ok(texts);
        }
    }
}
