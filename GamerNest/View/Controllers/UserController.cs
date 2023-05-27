using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;
using System.Text.RegularExpressions;

namespace View.Controllers
{
    public class UserController :MethodBaseController
    {
        public ActionResult JoinForm()
        {
            try
            {
                UserDefault();
                WebText( "UserJoinForm" );
                return View( "Join" );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Article" );
            }
            
        }

        public ActionResult Join(UserJoinModel model, IFormFile avatar)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();
                bool usernameExist = false;
                bool emailExist = false;

                string passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&+])[A-Za-z\d@$!%*?&+]{8,}$";

                bool confirmPass = false;

                ModelState.Remove( "avatar" );

                if ( ModelState.IsValid )
                {
                    usernameExist = CheckIfUserDataExist(-1, model.username);
                    emailExist = CheckIfUserDataExist( -1, "", model.email );

                    if ( emailExist )
                    {
                        errorMessageList.Add( ViewData[ "EmailExist" ].ToString() );
                    }

                    if ( usernameExist )
                    {
                        errorMessageList.Add( ViewData[ "UsernameExist" ].ToString() );
                    }

                    if ( ConfirmPassword( model.password, model.confirmPassword ) )
                    {
                        if ( !Regex.IsMatch( model.password, passwordRegex ) )
                        {
                            errorMessageList.Add( ViewData[ "InvalidPassword" ].ToString() );
                        }
                        else
                        {
                            confirmPass = true;
                        }
                    }
                    else
                    {
                        errorMessageList.Add( ViewData[ "MismatchPasswords" ].ToString() );
                    }

                    if ( !emailExist && !usernameExist && confirmPass )
                    {
                        CreateUserProcedure( model );
                        GetUser( -1, model.username );
                        int userId = lists.userList[0].id;
                        model.avatar = UploadImage( avatar, userId, "Avatar", "User", "avatar" );
                        UpdateUserJoinProcedure( model, false );

                        GetUser(-1, model.username);
                        SetUserSessions();

                        return RedirectToAction( "Index", "Article" );
                    }
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }

                UserDefault();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "UserJoinForm" );
                return View( "Join", model );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Article" );
            }
        }

        public ActionResult LogInForm()
        {
            try
            {
                UserDefault();
                WebText( "UserJoinForm" );
                return View( "LogIn" );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Article" );
            }
        }

        public ActionResult LogOut()
        {
            try
            {
                HttpContext.Session.Clear();
                WebText( "UserJoinForm" );
                return RedirectToAction("Index", "Article");
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Article" );
            }
        }

        public ActionResult LogIn(UserLogInModel model)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();
                bool correctPassword = false;

                if ( ModelState.IsValid )
                {
                    correctPassword = CheckIfUserLogIn( model.username, model.password );
                    if ( correctPassword )
                    {
                        GetUser( -1, model.username );
                        SetUserSessions();
                        return RedirectToAction( "Index", "Article" );

                    }
                    else
                    {
                        errorMessageList.Add( ViewData[ "IncorrectUsernameOrPassword" ].ToString() );
                    }
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                UserDefault();
                WebText( "UserLogInForm" );
                return View( "Login" );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Article" );
            }
        }

        public ActionResult UserPage()
        {
            try
            {
                UserDefault();
                WebText( "UserJoinForm" );
                return View( "Join" );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Article" );
            }
        }

        public bool CheckIfUserDataExist(int id = -1, string username = "", string email = "")
        {
            GetUser(id, username, email);

            if (lists.userList.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public void CreateUserProcedure(UserJoinModel model)
        {
            UserService.CreateUser( model.username, model.password, model.email, model.avatar, model.preferedLanguage, model.birthday, model.creationDate );
        }

        public void UpdateUserJoinProcedure(UserJoinModel model, bool changedPassword = false)
        {

            UserService.UpdateUser( model.id, model.username, changedPassword, model.password, model.email, model.avatar, model.preferedLanguage, model.birthday, model.creationDate );
        }

        public void UpdateUserProcedure(UpdateUserModel model, bool changedPassword = false)
        {

            UserService.UpdateUser( model.id, model.username, changedPassword, model.password, model.email, model.avatar, model.preferedLanguage, model.birthday, model.creationDate );
        }

        public void DeleteUserProcedure(int id)
        {
            UserService.DeleteUser( id );
        }
    }
}
