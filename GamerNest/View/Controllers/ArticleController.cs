using Domain;
using Microsoft.AspNetCore.Mvc;
using Support;
using System.Diagnostics;
using View.Models;

namespace View.Controllers
{
    public class ArticleController :Controller
    {
        ModelList lists = new ModelList();
        private readonly ILogger<ArticleController> _logger;

        public ArticleController(ILogger<ArticleController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index()
        {
            GetAllPlatforms();
            GetAllAuthors();

            return View( lists );
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

        public void GetAllPlatforms()
        {
            lists.platformList = PlatformService.GetAllPlatforms( "name");
        }

        public void GetAllAuthors()
        {
            lists.authorList = AuthorService.GetAllAuthors();
        }
    }
}
