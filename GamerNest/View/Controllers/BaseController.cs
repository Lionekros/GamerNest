using Domain;
using LogError;
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

        public void SetAdminSessions()
        {
            HttpContext.Session.SetString( "AdminEmail", lists.authorList[ 0 ].email );
            HttpContext.Session.SetString( "AdminFullName", lists.authorList[ 0 ].name + " " + lists.authorList[ 0 ].firstLastName + " " + lists.authorList[ 0 ].secondLastName );
            HttpContext.Session.SetString( "AdminAvatar", lists.authorList[ 0 ].avatar ?? string.Empty );
            HttpContext.Session.SetString( "AdminType", FetchUserType( lists.authorList[ 0 ].isAdmin ) );

            HttpContext.Session.SetString( "PageLanguage", lists.authorList[ 0 ].preferedLanguage );
        }

        public ActionResult ChangeLanguage(string lang, string cont, string act)
        {
            HttpContext.Session.SetString( "PageLanguage", lang );
            return RedirectToAction( act, cont );
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

        public bool ConfirmPassword(string newPassword, string confirmPassword)
        {
            if ( newPassword == confirmPassword && newPassword != null && confirmPassword != null )
            {
                return true;
            }
            return false;
        }

        public string UploadImage(IFormFile avatar, int id, string path1, string path2 = "")
        {
            if ( avatar != null && avatar.Length > 0 )
            {
                string directoryPath;
                if ( !string.IsNullOrEmpty( path2 ) )
                {
                    directoryPath = Path.Combine( Directory.GetCurrentDirectory(), "wwwroot", "img", path1, path2 );
                }
                else
                {
                    directoryPath = Path.Combine( Directory.GetCurrentDirectory(), "wwwroot", "img", path1 );
                }
                Directory.CreateDirectory( directoryPath );
                string fileName = "avatar_" + id + Path.GetExtension(avatar.FileName);
                string filePath = Path.Combine(directoryPath, fileName);
                using ( var stream = new FileStream( filePath, FileMode.Create ) )
                {
                    avatar.CopyTo( stream );
                }
                return "/" + Path.Combine( "img", "Avatar", "Author", fileName ).Replace( '\\', '/' );
            }

            return "";
        }

    }
}
