using Microsoft.AspNetCore.Mvc;
using shopping_list_et.infrastructure.Services;

namespace shopping_list_et.api.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class ImageTextRecognitionController : ControllerBase
    {
        private readonly TextFromImageService textFromImageService;

        public ImageTextRecognitionController(TextFromImageService textFromImageService)
        {
            this.textFromImageService = textFromImageService;
        }

        [HttpPost]
        public async Task<IActionResult> Upload(IFormFile file, CancellationToken cancellationToken)
        {
            using (var fileStream = file.OpenReadStream())
            {
                var text = await textFromImageService.GetText(fileStream, cancellationToken);

                return Ok(text);
            };
        }
    }
}
