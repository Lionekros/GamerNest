using Domain;
using Google.Protobuf.Collections;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;
using System.Xml.Linq;

namespace View.Controllers
{
    public class AdminArticleController : MethodBaseController
    {
        public ActionResult Articles
            (
                  int page = 1
                , int pageSize = 5,
                string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = -1, string orderBy = ""
            )
        {
            try
            {
                SetDefaultAdminViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                else if ( HttpContext.Session.GetString( "AdminType" ) != "Admin" )
                {
                    GetAllArticles( language, HttpContext.Session.GetString( "AdminEmail" ), idGame, id, headline, isPublished, orderBy );
                    FiltersViewBag( language, HttpContext.Session.GetString( "AdminEmail" ), idGame, id, headline, isPublished, orderBy );
                }
                else
                {
                    GetAllArticles( language, author, idGame, id, headline, isPublished, orderBy );
                    FiltersViewBag( language, author, idGame, id, headline, isPublished, orderBy );
                }
                
                Pagination( page, pageSize );
                
                WebText( "AdminArticle" );
                return View( "Article", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminArticle" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Preview(int id)
        {
            if ( HttpContext.Session.GetString( "AdminType" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }

            SetDefaultAdminViewDatas();

            GetArticle( id );
            GetAuthor( lists.articleList[ 0 ].author );

            WebText( "ArticlePreview" );

            return View( "ArticlePreview", lists );
        }

        public ActionResult CreateForm()
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == null)
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                
                SetDefaultAdminViewDatas();
                WebText( "AdminArticleForm" );
                ArticleModel model = new ArticleModel();
                model.gameList = GameService.GetAllGames();
                model.author = HttpContext.Session.GetString( "AdminEmail" );
                return View( "CreateArticle", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult UpdateForm(int id)
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == "" )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultAdminViewDatas();
                GetArticleUpdate( id );
                UpdateArticleModel model = lists.updateArticleList[0];
                model.gameList = GameService.GetAllGames();

                List<GameModel> tempList = GameService.GetAllGames("","",model.id);

                model.idGameList = new List<long>();

                foreach (var item in tempList)
                {
                    model.idGameList.Add(item.id);
                }
                WebText( "AdminArticleForm" );
                return View( "UpdateArticle", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult Create(ArticleModel model, IFormFile cover)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                ModelState.Remove( "cover" );

                GetAuthor(model.author);
                model.idAuthor = lists.authorList[0].id;

                model.createdDate = DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" );

                if ( ModelState.IsValid )
                {
                    CreateArticleProcedure( model );
                    GetAllArticles("", "", -1, -1, "", -1, "id");
                    int lastIndex = lists.articleList.Count - 1;
                    model.id = lists.articleList[ lastIndex ].id;
                    model.cover = UploadImage( cover, model.id, "Cover", "Article", "cover" );
                    ArticleService.UpdateArticle( model.id, model.headline, model.summary, model.body, model.cover, model.isPublished, model.createdDate, model.idAuthor, model.language, model.updatedDate, model.idGameList );
                    return RedirectToAction( "Articles" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminArticleForm" );
                model.gameList = GameService.GetAllGames();
                model.author = HttpContext.Session.GetString( "AdminEmail" );
                return View( "CreateArticle", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Update(UpdateArticleModel model, IFormFile cover)
        {

            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                ModelState.Remove( "cover" );

                GetAuthor( model.author );
                model.idAuthor = lists.authorList[ 0 ].id;

                model.updatedDate = DateTime.Now.ToString( "yyyy-MM-dd HH:mm:ss" );

                if ( ModelState.IsValid )
                {
                    model.cover = UploadImage( cover, model.id, "Cover", "Article", "cover" );
                    UpdateArticleProcedure( model );
                    return RedirectToAction( "Articles" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                model.gameList = GameService.GetAllGames();
                model.author = HttpContext.Session.GetString( "AdminEmail" );
                WebText( "AdminArticleForm" );
                return View( "UpdateArticle", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Delete(int id)
        {
            DeleteArticleProcedure( id );
            return RedirectToAction( "Articles" );
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

        public void CreateArticleProcedure(ArticleModel model)
        {
            ArticleService.CreateArticle( model.headline, model.summary, model.body, model.cover, model.isPublished, model.createdDate, model.idAuthor, model.language, model.updatedDate, model.idGameList);
        }

        public void UpdateArticleProcedure(UpdateArticleModel model)
        {

            ArticleService.UpdateArticle( model.id, model.headline, model.summary, model.body, model.cover, model.isPublished, model.createdDate, model.idAuthor, model.language, model.updatedDate, model.idGameList );
        }

        public void DeleteArticleProcedure(int id)
        {
            ArticleService.DeleteArticle( id );
        }

        public void FiltersViewBag
            (
                  string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = -1, string orderBy = ""
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
                orderBy = orderBy
            };
        }
    }
}
