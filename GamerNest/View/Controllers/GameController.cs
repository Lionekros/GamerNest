using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class GameController :Controller
    {
        ModelList lists = new ModelList();

        public IActionResult Index()
        {
            return View();
        }
    }
}
