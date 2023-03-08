using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class AdminController :Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
