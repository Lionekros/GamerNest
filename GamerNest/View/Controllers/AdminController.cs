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
            SetDefaultViewDatas();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }

            return View();
        }

        public ActionResult LogInForm()
        {
            WebText( "Login");
            return View("Login");
        }
        public ActionResult LogOut()
        {
            HttpContext.Session.Clear();
            return RedirectToAction( "LogInForm", "Admin" );
        }

        [HttpPost]
        public ActionResult LogIn(AdminLogIn login)
        {
            try
            {
                bool correctPassword = false;

                if ( ModelState.IsValid )
                {
                    correctPassword = CheckIfEmailAndPasswordIsCorrect( login.email, login.password );
                    if ( correctPassword )
                    {
                        GetAuthor( login.email );

                        // Get in sessions all the data that we will need in the future
                        HttpContext.Session.SetString( "AdminEmail", login.email );
                        HttpContext.Session.SetString( "AdminFullName", lists.authorList[ 0 ].name + " " + lists.authorList[ 0 ].firstLastName + " " + lists.authorList[ 0 ].secondLastName );
                        HttpContext.Session.SetString( "AdminAvatar", lists.authorList[ 0 ].avatar );
                        HttpContext.Session.SetString( "AdminType", FetchUserType( lists.authorList[ 0 ].isAdmin ) );

                        HttpContext.Session.SetString( "PageLanguage", lists.authorList[ 0 ].preferedLanguage );


                        return RedirectToAction( "Index", "Admin" );
                    }
                    else
                    {
                        ViewBag.UsuMessage = "Incorrect email or password";
                        WebText( "Login" );
                        return View( "Login", login );
                    }
                }
                else
                {
                    ViewBag.Message = "Fill all data";
                    WebText( "Login" );
                    return View( "Login", login );
                }
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
