using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class AdminDevController :BaseController
    {
        public ActionResult Devs()
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
