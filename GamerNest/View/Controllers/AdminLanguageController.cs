using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminLanguageController :MethodBaseController
    {
        public ActionResult Languages
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
                GetAllLanguages( language, idGame, id, name, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( language, idGame, id, name, orderBy );
                WebText( "AdminLanguage" );
                return View( "Language", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminLanguage" );
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
                WebText( "AdminLanguageForm" );
                return View( "CreateLanguage" );
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
                GetLanguageUpdate( id );
                UpdateGenreTypeLanguageModel model = lists.updateLanguageList[0];
                WebText( "AdminLanguageForm" );
                return View( "UpdateLanguage", model );
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
                    CreateLanguageProcedure( model );
                    return RedirectToAction( "Languages" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminLanguageForm" );
                return View( "CreateLanguage", model );
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
                    UpdateLanguageProcedure( model );
                    return RedirectToAction( "Languages" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminLanguageForm" );
                return View( "UpdateLanguage", model );
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
            DeleteLanguageProcedure( id );
            return RedirectToAction( "Languages" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.languageList != null )
            {
                int totalLanguages = lists.languageList.Count;

                int skippedLanguages = (page - 1) * pageSize;

                lists.languageList = lists.languageList.Skip( skippedLanguages ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalLanguages;
            }
        }

        public void CreateLanguageProcedure(GenreTypeLanguageModel model)
        {
            LanguageService.CreateLanguage( model.name, model.language );
        }

        public void UpdateLanguageProcedure(UpdateGenreTypeLanguageModel model)
        {

            LanguageService.UpdateLanguage( model.id, model.name, model.language );
        }

        public void DeleteLanguageProcedure(int id)
        {
            LanguageService.DeleteLanguage( id );
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
