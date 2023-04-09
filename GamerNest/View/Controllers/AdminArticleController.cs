using Domain;
using Google.Protobuf.Collections;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminArticleController : BaseController
    {
        public ActionResult Articles()
        {
            SetDefaultViewDatas();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            return View();
        }
    }
}
