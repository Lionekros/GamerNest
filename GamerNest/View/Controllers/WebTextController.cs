using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class WebTextController :BaseController
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
