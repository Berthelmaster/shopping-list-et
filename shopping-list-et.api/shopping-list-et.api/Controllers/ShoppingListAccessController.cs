using Microsoft.AspNetCore.Mvc;

namespace shopping_list_et.api.Controllers
{
    [Route("api/v1/[controller]")]
    [ApiController]
    public class ShoppingListAccessController : ControllerBase
    {
        private readonly ShoppingListConfiguration shoppingListConfiguration;

        public ShoppingListAccessController(ShoppingListConfiguration shoppingListConfiguration)
        {
            this.shoppingListConfiguration = shoppingListConfiguration;
        }

        [HttpGet]
        public async Task<IActionResult> RequestAccess([FromQuery] string accessCode)
        {
            bool accessCodeAccepted = accessCode == shoppingListConfiguration.AccessCode;

            if (!accessCodeAccepted)
                return BadRequest();

            return Ok(shoppingListConfiguration.AccessToken);
        }
    }
}
