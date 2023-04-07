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
    public class AdminController :Controller
    {

        ModelList lists = new ModelList();


        public ActionResult Index()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }

            return View();
        }

        public ActionResult Articles()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            return View();
        }


        public ActionResult Authors()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }

            return View();
        }

        public ActionResult Devs()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult Games()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult Genres()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult Languages()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult Platforms()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult PlayerTypes()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult Publishers()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult Users()
        {
            SetViewBags();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
            {
                return RedirectToAction( "Index", "Admin" );
            }

            return View();
        }

        public ActionResult LogInForm()
        {
            return View("Login");
        }
        public ActionResult LogOut()
        {
            HttpContext.Session.Clear();
            return RedirectToAction( "LogInForm", "Admin" );
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
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


                        return RedirectToAction( "Index", "Admin" );
                    }
                    else
                    {
                        ViewBag.UsuMessage = "Incorrect email or password";
                        return View( "Login", login );
                    }
                }
                else
                {
                    ViewBag.UsuMessage = "Fill all data";
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
            bool correct = false;

            GetAuthor( email );

            if ( lists.authorList[0].email == email )
            {
                if ( Utility.VerifyPassword(password, lists.authorList[ 0 ].password ) )
                {
                    correct = true;
                }
            }
            return correct;
        }
        public bool CheckIfAuthorExist(string email)
        {
            bool correct = false;

            GetAuthor( email );

            if ( lists.authorList[ 0 ].email == email )
            {
                correct = true;
            }
            return correct;
        }

        public void GetAuthor(string email)
        {
            lists.authorList = AuthorService.GetAuthor( email );
        }

        public string FetchUserType(sbyte type)
        {
            if ( type == 0 )
            {
                return "Author";
            }
            else
            {
                return "Admin";
            }
        }

        public void SetViewBags()
        {
            ViewBag.AdminEmail = HttpContext.Session.GetString( "AdminEmail" );
            ViewBag.AdminFullName = HttpContext.Session.GetString( "AdminFullName" );
            ViewBag.AdminType = HttpContext.Session.GetString( "AdminType" );
            ViewBag.AdminAvatar = HttpContext.Session.GetString( "AdminAvatar" );
        }

    }
}
