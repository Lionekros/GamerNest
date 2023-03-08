using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class GameController :Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
