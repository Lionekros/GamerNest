using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminPlayerTypeController :MethodBaseController
    {
        public ActionResult PlayerTypes
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
                GetAllPlayerTypes( language, idGame, id, name, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( language, idGame, id, name, orderBy );
                WebText( "AdminPlayerType" );
                return View( "PlayerType", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminPlayerType" );
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
                WebText( "AdminPlayerTypeForm" );
                return View( "CreatePlayerType" );
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
                GetPlayerTypeUpdate( id );
                UpdateGenreTypeLanguageModel model = lists.updatePlayerTypeList[0];
                WebText( "AdminPlayerTypeForm" );
                return View( "UpdatePlayerType", model );
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
                    CreatePlayerTypeProcedure( model );
                    return RedirectToAction( "PlayerTypes" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminPlayerTypeForm" );
                return View( "CreatePlayerType", model );
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
                    UpdatePlayerTypeProcedure( model );
                    return RedirectToAction( "PlayerTypes" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminPlayerTypeForm" );
                return View( "UpdatePlayerType", model );
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
            DeletePlayerTypeProcedure( id );
            return RedirectToAction( "PlayerTypes" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.playerTypeList != null )
            {
                int totalPlayerTypes = lists.playerTypeList.Count;

                int skippedPlayerTypes = (page - 1) * pageSize;

                lists.playerTypeList = lists.playerTypeList.Skip( skippedPlayerTypes ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalPlayerTypes;
            }
        }

        public void CreatePlayerTypeProcedure(GenreTypeLanguageModel model)
        {
            PlayerTypeService.CreatePlayerType( model.name, model.language );
        }

        public void UpdatePlayerTypeProcedure(UpdateGenreTypeLanguageModel model)
        {

            PlayerTypeService.UpdatePlayerType( model.id, model.name, model.language );
        }

        public void DeletePlayerTypeProcedure(int id)
        {
            PlayerTypeService.DeletePlayerType( id );
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
