using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class WebTextController :MethodBaseController
    {
        public ActionResult Texts
            (
                  int page = 1
                , int pageSize = 5
                , int id = -1, string title = "", int idCategory = -1, string language = "", string orderBy = ""
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
                GetAllTexts( id, title, idCategory, language, orderBy);
                GetAllCategories();
                Pagination( page, pageSize );
                FiltersViewBag( id, title, idCategory, language, orderBy);
                WebText( "AdminText" );
                return View( "WebText", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminText" );
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
                WebText( "AdminTextForm" );
                return View( "CreateText" );
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
                GetTextUpdate( id );
                UpdateWebTextModel model = lists.updateWebTextList[0];
                WebText( "AdminTextForm" );
                return View( "UpdateText", model );
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

        public ActionResult Create(WebTextModel model)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    CreateTextProcedure( model );
                    return RedirectToAction( "Texts" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminTextForm" );
                return View( "CreateText", model );
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

        public ActionResult Update(UpdateWebTextModel model)
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    UpdateTextProcedure( model );
                    return RedirectToAction( "Texts" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminTextForm" );
                return View( "UpdateText", model );
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
            DeleteTextProcedure( id );
            return RedirectToAction( "Texts" );
        }

        public void Pagination(int page, int pageSize)
        {
            int totalTexts = lists.webTextList.Count;

            int skippedTexts = (page - 1) * pageSize;

            lists.webTextList = lists.webTextList.Skip( skippedTexts ).Take( pageSize ).ToList();

            lists.PageSize = pageSize;
            lists.CurrentPage = page;
            lists.TotalItems = totalTexts;
        }

        public void CreateTextProcedure(WebTextModel model)
        {
            WebTextService.CreateText( model.title, model.text, model.idCategory, model.language);
        }

        public void UpdateTextProcedure(UpdateWebTextModel model)
        {

            WebTextService.UpdateText( model.id, model.title, model.text, model.idCategory, model.language );
        }

        public void DeleteTextProcedure(int id)
        {
            WebTextService.DeleteText( id );
        }

        public void FiltersViewBag
            (
                int id = -1, string title = "", int idCategory = -1, string language = "", string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                id = id,
                title = title,
                idCategory = idCategory,
                language = language,
                orderBy = orderBy
            };
        }


    }
}
