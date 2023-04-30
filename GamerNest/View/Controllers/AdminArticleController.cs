using Domain;
using Google.Protobuf.Collections;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminArticleController : MethodBaseController
    {
        public ActionResult Articles()
        {
            SetDefaultViewDatas();

            if ( HttpContext.Session.GetString( "AdminType" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            return View();
        }
    }
}
