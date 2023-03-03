using Domain;
using Microsoft.AspNetCore.Mvc;
using Support;
using System.Diagnostics;
using View.Models;

namespace View.Controllers
{
    public class HomeController :Controller
    {
        ModelList lists = new ModelList();
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            GetPlatforms();
            return View(lists);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache( Duration = 0, Location = ResponseCacheLocation.None, NoStore = true )]
        public IActionResult Error()
        {
            return View( new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier } );
        }

        public void GetPlatforms()
        {
            lists.platformList = PlatformService.GetPlatforms();
        }
    }
}