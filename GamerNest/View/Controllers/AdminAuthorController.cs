using Domain;
using Google.Protobuf.Collections;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminAuthorController :BaseController
    {
        public ActionResult Authors()
        {
            SetDefaultViewDatas();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            GetAllAuthors();

            return View( "Authors", lists );
        }

        public void GetAllAuthors()
        {
            lists.authorList = AuthorService.GetAllAuthors( "id" );
        }
        public void GetAuthor(string email)
        {
            lists.authorList = AuthorService.GetAuthor( email );
        }
    }
}
