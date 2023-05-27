using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminUserController :MethodBaseController
    {
        public ActionResult Users
            (
                  int page = 1
                , int pageSize = 10,
                  int id = -1, string username = "", string email = "", string orderBy = ""
            )
        {
            try
            {
                SetDefaultAdminViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "Index", "Article" );
                }
                else if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "Index", "Admin" );
                }
                GetAllUsers( id, username, email, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( id, username, email, orderBy );
                WebText( "AdminUser" );
                return View( "User", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminUser" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult CreateForm()
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == null || HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "Index", "Article" );
                }
                SetDefaultAdminViewDatas();
                WebText( "AdminUserForm" );
                return View( "CreateUser" );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult UpdateForm(int id)
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "Index", "Article" );
                }
                SetDefaultAdminViewDatas();
                GetUserUpdate( id );
                UpdateUserModel model = lists.updateUserList[0];
                WebText( "AdminUserForm" );
                return View( "UpdateUser", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult Create(UserModel model, IFormFile avatar)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                ModelState.Remove( "avatar" );

                if ( ModelState.IsValid )
                {
                    CreateUserProcedure( model );
                    GetUser( -1, model.username );
                    int userId = lists.userList[0].id;
                    model.avatar = UploadImage( avatar, userId, "Avatar", "User", "avatar" );
                    return RedirectToAction( "Users" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminUserForm" );
                return View( "CreateUser", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Update(UpdateUserModel model, IFormFile avatar)
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();

                ModelState.Remove( "avatar" );

                if ( ModelState.IsValid )
                {
                    model.avatar = UploadImage( avatar, model.id, "Avatar", "User", "avatar" );
                    UpdateUserProcedure( model );
                    return RedirectToAction( "Users" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminUserForm" );
                return View( "UpdateUser", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Delete(int id)
        {
            DeleteUserProcedure( id );
            return RedirectToAction( "Users" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.userList != null )
            {
                int totalUsers = lists.userList.Count;

                int skippedUsers = (page - 1) * pageSize;

                lists.userList = lists.userList.Skip( skippedUsers ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalUsers;
            }
        }

        public void CreateUserProcedure(UserModel model)
        {
            UserService.CreateUser( model.username, model.password, model.email, model.avatar, model.preferedLanguage, model.birthday, model.creationDate );
        }

        public void UpdateUserProcedure(UpdateUserModel model, bool changedPassword = false)
        {

            UserService.UpdateUser( model.id, model.username, changedPassword, model.password, model.email, model.avatar, model.preferedLanguage, model.birthday, model.creationDate );
        }

        public void DeleteUserProcedure(int id)
        {
            UserService.DeleteUser( id );
        }

        public void FiltersViewBag
            (
                 int id = -1, string username = "", string email = "", string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                id = id,
                username = username,
                email = email,
                orderBy = orderBy
            };
        }
    }
}
