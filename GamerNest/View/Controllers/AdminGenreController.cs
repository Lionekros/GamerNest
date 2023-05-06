using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminGenreController :MethodBaseController
    {
        public ActionResult Genres
            (
                  int page = 1
                , int pageSize = 10
                , string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = ""
            )
        {
            try
            {
                SetDefaultViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                else if ( HttpContext.Session.GetString( "AdminType" ) != "Admin" )
                {
                    return RedirectToAction( "Index", "Admin" );
                }
                GetAllGenres( language, idGame, id, name, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( language, idGame, id, name, orderBy );
                WebText( "AdminGenre" );
                return View( "Genre", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminGenre" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult CreateForm()
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == null || HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultViewDatas();
                WebText( "AdminGenreForm" );
                return View( "CreateGenre" );
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
                if ( HttpContext.Session.GetString( "AdminType" ) != "Admin" )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultViewDatas();
                GetGenreUpdate( id );
                UpdateGenreTypeLanguageModel model = lists.updateGenreList[0];
                WebText( "AdminGenreForm" );
                return View( "UpdateGenre", model );
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

        public ActionResult Create(GenreTypeLanguageModel model)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    CreateGenreProcedure( model );
                    return RedirectToAction( "Genres" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminGenreForm" );
                return View( "CreateGenre", model );
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

        public ActionResult Update(UpdateGenreTypeLanguageModel model)
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    UpdateGenreProcedure( model );
                    return RedirectToAction( "Genres" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminGenreForm" );
                return View( "UpdateGenre", model );
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
            DeleteGenreProcedure( id );
            return RedirectToAction( "Genres" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.genreList != null )
            {
                int totalGenres = lists.genreList.Count;

                int skippedGenres = (page - 1) * pageSize;

                lists.genreList = lists.genreList.Skip( skippedGenres ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalGenres;
            }
        }

        public void CreateGenreProcedure(GenreTypeLanguageModel model)
        {
            GenreService.CreateGenre( model.name, model.language );
        }

        public void UpdateGenreProcedure(UpdateGenreTypeLanguageModel model)
        {

            GenreService.UpdateGenre( model.id, model.name, model.language );
        }

        public void DeleteGenreProcedure(int id)
        {
            GenreService.DeleteGenre( id );
        }

        public void FiltersViewBag
            (
                  string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                language = language,
                idGame = idGame,
                id = id,
                name = name,
                orderBy = orderBy
            };
        }
    }
}
