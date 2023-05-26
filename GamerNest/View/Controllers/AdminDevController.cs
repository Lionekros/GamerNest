using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminDevController :MethodBaseController
    {
        public ActionResult Devs
            (
                  int page = 1
                , int pageSize = 10
                , int id = -1, string name = "", string orderBy = ""
            )
        {
            try
            {
                DeleteUserSessions();
                SetDefaultAdminViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "Index", "Article" );
                }
                GetAllDevs( id, name, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( id, name, orderBy );
                WebText( "AdminDev" );
                return View( "Dev", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminDev" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult CreateForm()
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "Index", "Article" );
                }
                else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "Index", "Admin" );
                }
                SetDefaultAdminViewDatas();
                WebText( "AdminDevForm" );
                return View( "CreateDev" );
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
                if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "Index", "Article" );
                }
                SetDefaultAdminViewDatas();
                GetDevUpdate( id );
                UpdateDevPublisherModel model = lists.updateDevList[0];
                WebText( "AdminDevForm" );
                return View( "UpdateDev", model );
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

        public ActionResult Create(DevPublisherModel model)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    CreateDevProcedure( model );
                    return RedirectToAction( "Devs" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminDevForm" );
                return View( "CreateDev", model );
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

        public ActionResult Update(UpdateDevPublisherModel model)
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    UpdateDevProcedure( model );
                    return RedirectToAction( "Devs" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminDevForm" );
                return View( "UpdateDev", model );
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
            DeleteDevProcedure( id );
            return RedirectToAction( "Devs" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.devList != null )
            {
                int totalDevs = lists.devList.Count;

                int skippedDevs = (page - 1) * pageSize;

                lists.devList = lists.devList.Skip( skippedDevs ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalDevs;
            }
        }

        public void CreateDevProcedure(DevPublisherModel model)
        {
            DevService.CreateDev( model.name );
        }

        public void UpdateDevProcedure(UpdateDevPublisherModel model)
        {

            DevService.UpdateDev( model.id, model.name );
        }

        public void DeleteDevProcedure(int id)
        {
            DevService.DeleteDev( id );
        }

        public void FiltersViewBag
            (
                  int id = -1, string name = "", string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                id = id,
                name = name,
                orderBy = orderBy
            };
        }
    }
}
