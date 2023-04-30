using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class AdminLanguageController :MethodBaseController
    {
        public ActionResult Languages()
        {
            SetDefaultViewDatas();

            if ( HttpContext.Session.GetString( "AdminType" ) == null )
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
