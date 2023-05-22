using Google.Protobuf.Collections;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class GameController :MethodBaseController
    {
        public ActionResult AllGames
            (
                  int page = 1
                , int pageSize = 5,
                string language = "", string user = "", int idArticle = -1, bool scored = false, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "title"
            )
        {
            try
            {
                UserDefault();
                language = HttpContext.Session.GetString( "PageLanguage" );

                GetAllGames( language, user, idArticle, id, title, subtitle, idPlatform, orderBy );
                FiltersViewBag( language, user, idArticle, scored, id, title, subtitle, idPlatform, orderBy );


                GetAllPlatforms( -1, "", "", "name" );

                Pagination( page, pageSize );

                WebText( "UserAllGames" );
                return View( "Game", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminGame" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.gameList != null )
            {
                int totalGames = lists.gameList.Count;

                int skippedGames = (page - 1) * pageSize;

                lists.gameList = lists.gameList.Skip( skippedGames ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalGames;
            }
        }

        public void FiltersViewBag
            (
                  string language = "", string user = "", int idArticle = -1, bool scored = false, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                language = language,
                user = user,
                idArticle = idArticle,
                scored = scored,
                id = id,
                title = title,
                subtitle = subtitle,
                idPlatform = idPlatform,
                orderBy = orderBy
            };
        }

    }
}
