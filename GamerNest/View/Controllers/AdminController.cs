using Domain;
using LogError;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Support;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;

namespace View.Controllers
{
    public class AdminController :MethodBaseController
    {
        public ActionResult Index()
        {
            try
            {
                SetDefaultViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }

                WebText("Admin");

                return View();

            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult LogInForm()
        {
            try
            {
                WebText( "Login" );
                return View( "Login" );
            }
            catch ( Exception ex )
            {
                
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Login" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }
        public ActionResult LogOut()
        {
            try
            {
                HttpContext.Session.Clear();
                return RedirectToAction( "LogInForm", "Admin" );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Login" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        [HttpPost]
        public ActionResult LogIn(AdminLogIn login)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();
                bool correctPassword = false;

                if ( ModelState.IsValid )
                {
                    correctPassword = CheckIfEmailAndPasswordIsCorrect( login.email, login.password );
                    if ( correctPassword )
                    {
                        GetAuthor( login.email );

                        if ( !lists.authorList[ 0 ].isActive )
                        {
                            errorMessageList.Add( ViewData[ "UserNotActive" ].ToString() );
                        }
                        else
                        {
                            // Get in sessions all the data that we will need in the future
                            SetAdminSessions();

                            return RedirectToAction( "Index", "Admin" );
                        }
                        
                    }
                    else
                    {
                        errorMessageList.Add( ViewData[ "IncorrectEmailOrPassword" ].ToString() );
                    }
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "Login" );
                return View( "Login", login );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Login" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Article" );
            }
        }

        public bool CheckIfEmailAndPasswordIsCorrect(string email, string password)
        {
            GetAuthor( email );

            if ( lists.authorList.Count > 0 )
            {
                if ( Utility.VerifyPassword( password, lists.authorList[ 0 ].password ) )
                {
                    return true;
                }
            }

            return false;
        }
        public bool CheckIfAuthorExist(string email)
        {
            GetAuthor( email );

            if ( lists.authorList.Count > 0 )
            {
                return true;
            }
                
            return false;
        }

    }
}
