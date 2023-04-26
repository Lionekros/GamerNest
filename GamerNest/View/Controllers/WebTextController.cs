﻿using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class WebTextController :BaseController
    {
       

        public ActionResult WebTextC()
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

            return View("WebText");
        }

        
    }
}
