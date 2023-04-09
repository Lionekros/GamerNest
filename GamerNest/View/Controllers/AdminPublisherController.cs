using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class AdminPublisherController :BaseController
    {
        public ActionResult Publishers()
        {
            SetDefaultViewDatas();

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
    }
}
