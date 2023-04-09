using Domain;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class BaseController :Controller
    {
        public ModelList lists = new ModelList();
        public void SetDefaultViewDatas()
        {
            ViewData[ "AdminEmail" ] = HttpContext.Session.GetString( "AdminEmail" );
            ViewData[ "AdminFullName" ] = HttpContext.Session.GetString( "AdminFullName" );
            ViewData[ "AdminType" ] = HttpContext.Session.GetString( "AdminType" );
            ViewData[ "AdminAvatar" ] = HttpContext.Session.GetString( "AdminAvatar" );
            ViewData[ "PageLanguage"] = HttpContext.Session.GetString( "PageLanguage" );
        }

        public void WebText(string cat)
        {
            string pageLanguage = HttpContext.Session.GetString("PageLanguage") ?? "ENG";

            GetAllTextsByCategory( cat, pageLanguage );
            WebTextViewData();
        }

        public void GetAllTextsByCategory(string cat, string lang = "ENG")
        {
            lists.webTextList = WebTextService.GetAllTextsByCategory( cat, lang );
        }

        public void WebTextViewData()
        {
            foreach ( var item in lists.webTextList )
            {
                ViewData[ item.title ] = item.text;
            }
        }

        public string FetchUserType(bool type)
        {
            if ( type == false )
            {
                return "Author";
            }
            else
            {
                return "Admin";
            }
        }
    }
}
