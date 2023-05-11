using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminPlatformController :MethodBaseController
    {
        public ActionResult Platforms
            (
                  int page = 1
                , int pageSize = 10,
                  int id = -1, string name = "", string icon = "", string orderBy = ""
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
                GetAllPlatforms( id, name, icon, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( id, name, icon, orderBy );
                WebText( "AdminPlatform" );
                return View( "Platform", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminPlatform" );
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
                WebText( "AdminPlatformForm" );
                return View( "CreatePlatform" );
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
                GetPlatformUpdate( id );
                UpdatePlatformModel model = lists.updatePlatformList[0];
                WebText( "AdminPlatformForm" );
                return View( "UpdatePlatform", model );
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

        public ActionResult Create(PlatformModel model)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    CreatePlatformProcedure( model );
                    return RedirectToAction( "Platforms" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminPlatformForm" );
                return View( "CreatePlatform", model );
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

        public ActionResult Update(UpdatePlatformModel model)
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    UpdatePlatformProcedure( model );
                    return RedirectToAction( "Platforms" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminPlatformForm" );
                return View( "UpdatePlatform", model );
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
            DeletePlatformProcedure( id );
            return RedirectToAction( "Platforms" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.platformList != null )
            {
                int totalPlatforms = lists.platformList.Count;

                int skippedPlatforms = (page - 1) * pageSize;

                lists.platformList = lists.platformList.Skip( skippedPlatforms ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalPlatforms;
            }
        }

        public void CreatePlatformProcedure(PlatformModel model)
        {
            PlatformService.CreatePlatform( model.name, model.icon );
        }

        public void UpdatePlatformProcedure(UpdatePlatformModel model)
        {

            PlatformService.UpdatePlatform( model.id, model.name, model.icon );
        }

        public void DeletePlatformProcedure(int id)
        {
            PlatformService.DeletePlatform( id );
        }

        public void FiltersViewBag
            (
                  int id = -1, string name = "", string icon = "", string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                id = id,
                name = name,
                icon = icon,
                orderBy = orderBy
            };
        }
    }
}
