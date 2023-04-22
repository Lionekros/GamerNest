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
    public class AdminController :BaseController
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
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
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
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
                return RedirectToAction( "Index", "Admin" );
            }

        }

        [HttpPost]
        public ActionResult LogIn(AdminLogIn login)
        {
            try
            {
                List<string> errorMessageList = new List<string>();
                bool correctPassword = false;

                if ( ModelState.IsValid )
                {
                    correctPassword = CheckIfEmailAndPasswordIsCorrect( login.email, login.password );
                    if ( correctPassword )
                    {
                        GetAuthor( login.email );

                        // Get in sessions all the data that we will need in the future
                        SetAdminSessions();

                        return RedirectToAction( "Index", "Admin" );
                    }
                    else
                    {
                        errorMessageList.Add( "Incorrect email or password" );
                    }
                }
                else
                {
                    errorMessageList.Add( "Fill all required data" );
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
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
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

        public void GetAuthor(string email)
        {
            lists.authorList = AuthorService.GetAuthor( email );
        }

    }
}
