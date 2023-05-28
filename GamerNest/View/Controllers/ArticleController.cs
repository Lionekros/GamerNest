using LogError;
using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class ArticleController :MethodBaseController
    {
        public ActionResult Index(
            int page = 1
                , int pageSize = 5,
                string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = 1, string orderBy = "createdDate", bool isFav = false, int user = -1)
        {
            try
            {
                UserDefault();
                language = HttpContext.Session.GetString( "PageLanguage" );
                if ( isFav )
                {
                    GetAllArticles( language, author, idGame, id, headline, isPublished, orderBy, isFav, int.Parse( HttpContext.Session.GetString( "UserID" ) ) );
                    FiltersViewBag( language, author, idGame, id, headline, isPublished, orderBy, isFav, int.Parse( HttpContext.Session.GetString( "UserID" ) ) );
                }
                else
                {
                    GetAllArticles( language, author, idGame, id, headline, isPublished, orderBy );
                    FiltersViewBag( language, author, idGame, id, headline, isPublished, orderBy );
                }

                Pagination( page, pageSize );

                WebText( "NormalArticle" );
                return View( "Index", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "NormalArticle" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult AllArticles(
            int page = 1
                , int pageSize = 10,
                string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = 1, string orderBy = "createdDate", bool isFav = false, int user = -1)
        {
            try
            {
                UserDefault();
                language = HttpContext.Session.GetString( "PageLanguage" );
                if ( isFav )
                {
                    GetAllArticles( language, author, idGame, id, headline, isPublished, orderBy, isFav, int.Parse( HttpContext.Session.GetString( "UserID" ) ) );
                    FiltersViewBag( language, author, idGame, id, headline, isPublished, orderBy, isFav, int.Parse( HttpContext.Session.GetString( "UserID" ) ) );
                }
                else
                {
                    GetAllArticles( language, author, idGame, id, headline, isPublished, orderBy );
                    FiltersViewBag( language, author, idGame, id, headline, isPublished, orderBy );
                }

                Pagination( page, pageSize );

                WebText( "NormalArticle" );
                return View( "AllArticles", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "NormalArticle" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult SeeArticle(int id)
        {
            UserDefault();

            GetArticle( id );
            GetAuthor( lists.articleList[ 0 ].author );

            WebText( "NormalArticle" );

            return View( "Article", lists );
        }



        public void Pagination(int page, int pageSize)
        {
            if ( lists.articleList != null )
            {
                int totalArticles = lists.articleList.Count;

                int skippedArticles = (page - 1) * pageSize;

                lists.articleList = lists.articleList.Skip( skippedArticles ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalArticles;
            }
        }

        public void FiltersViewBag
            (
                  string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = -1, string orderBy = "", bool isFav = false, int user = -1
            )
        {
            ViewBag.FormData = new
            {
                language = language,
                author = author,
                idGame = idGame,
                id = id,
                headline = headline,
                isPublished = isPublished,
                orderBy = orderBy,
                isFav = isFav,
                user = user
            };
        }
    }
}
