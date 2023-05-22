using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class MethodBaseController :GetBaseController
    {
        public void UserDefault()
        {
            DeleteAdminSession();
            SetDefaultPageLanguage();

            SetDefaultUserViewDatas();
        }
        public void SetDefaultAdminViewDatas()
        {
            DeleteUserSessions();
            ViewData[ "AdminEmail" ] = HttpContext.Session.GetString( "AdminEmail" );
            ViewData[ "AdminCanPublish" ] = HttpContext.Session.GetString( "AdminCanPublish" );
            ViewData[ "AdminFullName" ] = HttpContext.Session.GetString( "AdminFullName" );
            ViewData[ "AdminType" ] = HttpContext.Session.GetString( "AdminType" );
            ViewData[ "AdminAvatar" ] = HttpContext.Session.GetString( "AdminAvatar" );
            ViewData[ "PageLanguage"] = HttpContext.Session.GetString( "PageLanguage" );
        }

        public void SetAdminSessions()
        {
            HttpContext.Session.SetString( "AdminEmail", lists.authorList[ 0 ].email );
            HttpContext.Session.SetString( "AdminCanPublish", lists.authorList[ 0 ].canPublish.ToString() );
            HttpContext.Session.SetString( "AdminFullName", lists.authorList[ 0 ].name + " " + lists.authorList[ 0 ].firstLastName + " " + lists.authorList[ 0 ].secondLastName );
            HttpContext.Session.SetString( "AdminAvatar", lists.authorList[ 0 ].avatar ?? string.Empty );
            HttpContext.Session.SetString( "AdminType", FetchUserType( lists.authorList[ 0 ].isAdmin ) );
            HttpContext.Session.SetString( "PageLanguage", lists.authorList[ 0 ].preferedLanguage );
        }

        public void DeleteAdminSession()
        {
            HttpContext.Session.SetString( "AdminEmail", "" );
            HttpContext.Session.SetString( "AdminCanPublish", "" );
            HttpContext.Session.SetString( "AdminFullName", "" );
            HttpContext.Session.SetString( "AdminAvatar", "" );
            HttpContext.Session.SetString( "AdminType", "" );
            HttpContext.Session.SetString( "PageLanguage", "" );
        }

        public void SetDefaultUserViewDatas()
        {
            ViewData[ "UserID" ] = HttpContext.Session.GetString( "UserID" );
            ViewData[ "UserUsername" ] = HttpContext.Session.GetString( "UserUsername" );
            ViewData[ "UserEmail" ] = HttpContext.Session.GetString( "UserEmail" ) ?? "no";
            ViewData[ "UserAvatar" ] = HttpContext.Session.GetString( "UserAvatar" );
        }

        public void SetUserSessions()
        {
            HttpContext.Session.SetString( "UserID", lists.userList[ 0 ].id.ToString() );
            HttpContext.Session.SetString( "UserUsername", lists.userList[ 0 ].username );
            HttpContext.Session.SetString( "UserEmail", lists.userList[ 0 ].email );
            HttpContext.Session.SetString( "UserAvatar", lists.userList[ 0 ].avatar ?? string.Empty );
            HttpContext.Session.SetString( "PageLanguage", lists.userList[ 0 ].preferedLanguage ?? "ENG");
        }

        public void DeleteUserSessions()
        {
            HttpContext.Session.SetString( "UserID", "" );
            HttpContext.Session.SetString( "UserUsername", "" );
            HttpContext.Session.SetString( "UserEmail", "no" );
            HttpContext.Session.SetString( "UserAvatar", "" );
        }

        public ActionResult ChangeLanguage(string lang, string cont, string act)
        {
            HttpContext.Session.SetString( "PageLanguage", lang );
            return RedirectToAction( act, cont );
        }

        public void SetDefaultPageLanguage()
        {
            if ( string.IsNullOrEmpty( HttpContext.Session.GetString( "PageLanguage" )))
            {
                HttpContext.Session.SetString( "PageLanguage", "ENG" );
            }
        }

        public void WebText(string cat)
        {
            string pageLanguage = HttpContext.Session.GetString("PageLanguage") ?? "ENG";

            GetAllTextsByCategory( cat, pageLanguage );
            WebTextViewData();
        }

        public void WebTextViewData()
        {
            foreach ( var item in lists.textList )
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

        public string UploadImage(IFormFile avatar, int id, string path1, string path2 = "", string name = "")
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
                string fileName = name + "_" + id + Path.GetExtension(avatar.FileName);
                string filePath = Path.Combine(directoryPath, fileName);
                using ( var stream = new FileStream( filePath, FileMode.Create ) )
                {
                    avatar.CopyTo( stream );
                }
                return "/" + Path.Combine( "img", path1, path2, fileName ).Replace( '\\', '/' );
            }

            return "";
        }

        public bool CheckIfEmailAndPasswordIsCorrect(string email, string password)
        {
            GetAuthor( email );

            if ( lists.authorList?.Count > 0 )
            {
                if ( Utility.VerifyPassword( password, lists.authorList[ 0 ].password ) )
                {
                    return true;
                }
            }

            return false;
        }
        public bool CheckIfAuthorExist(string email)
        {
            GetAuthor( email );

            if ( lists.authorList?.Count > 0 )
            {
                return true;
            }

            return false;
        }

    }
}
