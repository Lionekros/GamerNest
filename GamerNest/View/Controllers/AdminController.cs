using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;
using System.Security.Claims;

namespace View.Controllers
{
    public class AdminController :Controller
    {

        ModelList lists = new ModelList();


        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Articles()
        {
            return View();
        }

        public ActionResult Authors()
        {
            return View();
        }

        public ActionResult Devs()
        {
            return View();
        }

        public ActionResult Games()
        {
            return View();
        }

        public ActionResult Genres()
        {
            return View();
        }

        public ActionResult Languages()
        {
            return View();
        }

        public ActionResult Platforms()
        {
            return View();
        }

        public ActionResult PlayerTypes()
        {
            return View();
        }

        public ActionResult Publishers()
        {
            return View();
        }

        public ActionResult Users()
        {
            return View();
        }

        public ActionResult LogInForm()
        {
            return View("Login");
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
                        return View(); //Acordarse de cambiar
                    }
                }
                else
                {
                    ViewBag.UsuMessage = "Rellene todos los datos";
                    return View( "Login", login );
                }

                return View(); //Acordarse de cambiar
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "Ha ocurrido un error, inténtelo de nuevo más tarde";
                return RedirectToAction( "Index", "Noticia" );
            }
        }

        public bool CheckIfEmailAndPasswordIsCorrect(string email, string password)
        {
            bool correct = false;

            lists.authorList = AuthorService.GetAuthor( email );

            if ( lists.authorList[0].email == email )
            {
                if ( lists.authorList[ 0 ].password == password )
                {
                    correct = true;
                }
            }
            return correct;
        }
        public bool CheckIfAuthorExist(string email)
        {
            bool correct = false;

            lists.authorList = AuthorService.GetAuthor( email );

            if ( lists.authorList[ 0 ].email == email )
            {
                correct = true;
            }
            return correct;
        }
    }
}
