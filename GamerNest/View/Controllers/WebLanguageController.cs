using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Mysqlx.Crud;
using Support;
using System.Text.RegularExpressions;
using System.Xml.Linq;

namespace View.Controllers
{
    public class WebLanguageController :MethodBaseController
    {
        public ActionResult WebLanguages
            (
                  int page = 1
                , int pageSize = 5
                , string id = ""
                , string name = ""
                , string orderBy = ""
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
                    return RedirectToAction( "Index", "Admin" );
                }
                GetAllWebLanguages(id, name, orderBy);
                Pagination( page, pageSize );
                FiltersViewBag( id, name, orderBy );
                WebText( "AdminWebLanguage" );
                return View("WebLanguage", lists);
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminWebLanguage" );
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
                SetDefaultAdminViewDatas();
                WebText( "AdminWebLanguageForm" );
                return View( "CreateWebLanguage" );
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

        public ActionResult UpdateForm(string id)
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) != "Admin")
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultAdminViewDatas();
                GetWebLanguageUpdate( id );
                UpdateWebLanguageModel webLanguage = lists.updateWebLanguageList[0];
                WebText( "AdminWebLanguageForm" );
                return View( "UpdateWebLanguage", webLanguage );
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

        public ActionResult Create(WebLanguageModel webLanguage)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    CreateWebLanguageProcedure( webLanguage );
                    return RedirectToAction( "WebLanguages" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminWebLanguageForm" );
                return View( "CreateWebLanguage", webLanguage );
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

        public ActionResult Update(UpdateWebLanguageModel webLanguage)
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    UpdateWebLanguageProcedure( webLanguage );
                    return RedirectToAction( "WebLanguages" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminWebLanguageForm" );
                return View( "UpdateWebLanguage", webLanguage );
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

        public ActionResult Delete(string id)
        {
            DeleteWebLanguageProcedure( id );
            return RedirectToAction( "WebLanguages" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.webLanguageList != null )
            {
                int totalWebLanguages = lists.webLanguageList.Count;

                int skippedWebLanguages = (page - 1) * pageSize;

                lists.webLanguageList = lists.webLanguageList.Skip( skippedWebLanguages ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalWebLanguages;
            }
        }

        public void CreateWebLanguageProcedure(WebLanguageModel webLang)
        {
            WebLanguageService.CreateWebLanguage(webLang.id, webLang.name, webLang.icon );
        }

        public void UpdateWebLanguageProcedure(UpdateWebLanguageModel webLang)
        {

            WebLanguageService.UpdateWebLanguage( webLang.id, webLang.name, webLang.icon );
        }

        public void DeleteWebLanguageProcedure(string id)
        {
            WebLanguageService.DeleteWebLanguage( id );
        }

        public void FiltersViewBag
            (
                  string id = ""
                , string name = ""
                , string orderBy = ""
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
