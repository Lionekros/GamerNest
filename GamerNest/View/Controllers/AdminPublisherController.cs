using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminPublisherController :MethodBaseController
    {
        public ActionResult Publishers
            (
                  int page = 1
                , int pageSize = 10
                , int id = -1, string name = "", string orderBy = ""
            )
        {
            try
            {
                SetDefaultViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                GetAllPublishers( id, name, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( id, name, orderBy );
                WebText( "AdminPublisher" );
                return View( "Publisher", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminPublisher" );
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
                WebText( "AdminPublisherForm" );
                return View( "CreatePublisher" );
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
                GetPublisherUpdate( id );
                UpdateDevPublisherModel model = lists.updatePublisherList[0];
                WebText( "AdminPublisherForm" );
                return View( "UpdatePublisher", model );
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
                    CreatePublisherProcedure( model );
                    return RedirectToAction( "Publishers" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminPublisherForm" );
                return View( "CreatePublisher", model );
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
                    UpdatePublisherProcedure( model );
                    return RedirectToAction( "Publishers" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminPublisherForm" );
                return View( "UpdatePublisher", model );
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
            DeletePublisherProcedure( id );
            return RedirectToAction( "Publishers" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.devList != null )
            {
                int totalPublishers = lists.devList.Count;

                int skippedPublishers = (page - 1) * pageSize;

                lists.devList = lists.devList.Skip( skippedPublishers ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalPublishers;
            }
        }

        public void CreatePublisherProcedure(DevPublisherModel model)
        {
            PublisherService.CreatePublisher( model.name );
        }

        public void UpdatePublisherProcedure(UpdateDevPublisherModel model)
        {

            PublisherService.UpdatePublisher( model.id, model.name );
        }

        public void DeletePublisherProcedure(int id)
        {
            PublisherService.DeletePublisher( id );
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
