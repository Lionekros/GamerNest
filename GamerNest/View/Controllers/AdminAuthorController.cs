using Domain;
using Microsoft.AspNetCore.Mvc;
using Support;
using LogError;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.Extensions.FileSystemGlobbing.Internal;
using System.Text.RegularExpressions;

namespace View.Controllers
{
    public class AdminAuthorController :BaseController
    {
        public ActionResult Authors
            (
                  int       page            = 1
                , int       pageSize        = 5
                , int       id              = -1
                , string    name            = ""
                , string    firstLastName   = ""
                , string    secondLastName  = ""
                , string    email           = ""
                , sbyte     isAdmin         = -1
                , sbyte     isActive        = -1
                , string    orderBy         = ""
            )
        {
            try
            {
                SetDefaultViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }

                if ( HttpContext.Session.GetString( "AdminType" ) == "Admin" )
                {
                    GetAllAuthors( id, name, firstLastName, secondLastName, email, isAdmin, isActive, orderBy );
                    Pagination( page, pageSize );

                    FiltersViewBag( id, name, firstLastName, secondLastName, email, isAdmin, isActive, orderBy );
                }
                else
                {
                    GetAuthor( HttpContext.Session.GetString( "AdminEmail" ) );
                }

                WebText( "AdminAuthor" );

                return View( "Authors", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminAuthor" );
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
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultViewDatas();
                WebText("AdminAuthorForm");
                return View( "CreateAuthor" );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminAuthor" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult UpdateForm(string email)
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultViewDatas();
                GetAuthorUpdate( email );
                UpdateAuthorModel author = lists.updateAuthorList[0];
                WebText( "AdminAuthorForm" );
                return View( "UpdateAuthor", author );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminAuthor" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult Create(AuthorModel author, IFormFile avatar)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();
                bool emailExist = false;
                bool phoneExist = false;

                ModelState.Remove( "avatar" );

                if ( ModelState.IsValid )
                {
                    emailExist = EmailOrPhoneExist( author.email, author.id );
                    phoneExist = EmailOrPhoneExist( author.phone, author.id );

                    if ( emailExist )
                    {
                        errorMessageList.Add( ViewData[ "EmailExist" ].ToString() );
                    }

                    if ( phoneExist )
                    {
                        errorMessageList.Add( ViewData[ "PhoneExist" ].ToString() );
                    }

                    author.avatar = UploadImage( avatar, author.id, "Avatar", "Author" );

                    if ( !emailExist && !phoneExist )
                    {
                        CreateAuthorProcedure( author );
                        return RedirectToAction( "Authors" );
                    }
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                return View( "CreateAuthor", author );
            }
            catch ( Exception ex )
            {
                
                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminAuthor" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Update(UpdateAuthorModel author, IFormFile avatar) 
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();
                bool emailExist = false;
                bool phoneExist = false;
                string passwordRegex = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&+])[A-Za-z\d@$!%*?&+]{8,}$";
                bool isMatch = false;
                bool confirmPass = false;
                bool changedPassword = false;

                ModelState.Remove( "avatar" );


                if ( ModelState.IsValid )
                {
                    emailExist = EmailOrPhoneExist( author.email, author.id );
                    phoneExist = EmailOrPhoneExist( author.phone, author.id );

                    if ( emailExist )
                    {
                        errorMessageList.Add( ViewData[ "EmailExist" ].ToString() );
                    }

                    if ( phoneExist )
                    {
                        errorMessageList.Add( ViewData[ "PhoneExist" ].ToString() );
                    }

                    if (avatar != null)
                    {
                        author.avatar = UploadImage( avatar, author.id, "Avatar", "Author" );
                    }
                    

                    if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
                    {
                        if ( author.oldPassword != "" && author.oldPassword != null )
                        {
                            if ( CheckPasswordAuthor( author.email, author.oldPassword ) )
                            {
                                if ( ConfirmPassword( author.newPassword, author.confirmPassword ) )
                                {
                                    if ( !Regex.IsMatch( author.newPassword, passwordRegex ) )
                                    {
                                        errorMessageList.Add( ViewData[ "InvalidPassword" ].ToString() );
                                    }
                                    else
                                    {
                                        isMatch = true;
                                        author.oldPassword = author.newPassword;
                                        changedPassword = true;
                                        confirmPass = true;
                                    }
                                }
                                else
                                {
                                    errorMessageList.Add( ViewData[ "MismatchPasswords" ].ToString() );
                                }
                            }
                            else
                            {
                                errorMessageList.Add( ViewData[ "ErrorOldPassword" ].ToString() );
                            }

                            if ( !emailExist && !phoneExist && confirmPass && isMatch )
                            {
                                UpdateAuthorProcedure( author, changedPassword );
                                GetAuthor( author.email );
                                SetAdminSessions();
                                return RedirectToAction( "Authors" );
                            }
                        }
                        else
                        {
                            if ( !emailExist && !phoneExist)
                            {
                                UpdateAuthorProcedure( author, changedPassword );
                                GetAuthor( author.email );
                                SetAdminSessions();
                                return RedirectToAction( "Authors" );
                            }
                        }
                    }
                    else
                    {
                        if ( author.oldPassword != "" && author.oldPassword != null )
                        {
                            if ( ConfirmPassword( author.oldPassword, author.confirmPassword ) )
                            {
                                confirmPass = true;
                                if ( !emailExist && !phoneExist && confirmPass )
                                {
                                    UpdateAuthorProcedure( author );
                                    GetAuthor( author.email );
                                    SetAdminSessions();
                                    return RedirectToAction( "Authors" );
                                }
                            }
                            else
                            {
                                errorMessageList.Add( ViewData[ "MismatchPasswords" ].ToString() );
                            }
                        }
                        else
                        {
                            if ( !emailExist && !phoneExist )
                            {
                                UpdateAuthorProcedure( author );
                                GetAuthor( author.email );
                                SetAdminSessions();
                                return RedirectToAction( "Authors" );
                            }
                        }
                        
                    }
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                return View( "UpdateAuthor", author );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminAuthor" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Delete(int id)
        {
            DeleteAuthorProcedure( id );
            return RedirectToAction( "Authors" );
        }

        public void GetAllAuthors
            (
                  int       id              = -1
                , string    name            = ""
                , string    firstLastName   = ""
                , string    secondLastName  = ""
                , string    email           = ""
                , sbyte     isAdmin         = -1
                , sbyte     isActive        = -1
                , string    orderBy         = ""
                , int       limit           = -1
            )
        {
            lists.authorList = AuthorService.GetAllAuthors(id, name, firstLastName, secondLastName, email, isAdmin, isActive, orderBy, limit );
        }

        public void GetAuthor(string email)
        {
            lists.authorList = AuthorService.GetAuthor( email );
        }

        public void GetAuthorUpdate(string email)
        {
            lists.updateAuthorList = AuthorService.GetAuthorUpdate( email );
        }

        public void Pagination(int page, int pageSize)
        {
            int totalAuthors = lists.authorList.Count;

            int skippedAuthors = (page - 1) * pageSize;

            lists.authorList = lists.authorList.Skip( skippedAuthors ).Take( pageSize ).ToList();

            lists.PageSize = pageSize;
            lists.CurrentPage = page;
            lists.TotalItems = totalAuthors;
        }

        public bool EmailOrPhoneExist(string emailOrPhone, int id)
        {
            GetAuthor( emailOrPhone );

            if ( lists.authorList.Count > 0 )
            {
                if ( id == lists.authorList[ 0 ].id )
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
            return false;

        }

        public void CreateAuthorProcedure(AuthorModel author)
        {
            AuthorService.CreateAuthor(author.name, author.firstLastName, author.secondLastName, author.password, author.email, author.phone, author.description, author.avatar, author.preferedLanguage, author.isAdmin, author
                .canPublish, author.isActive, author.birthday, author.startDate, author.endDate);
        }

        public bool CheckPasswordAuthor(string email, string password)
        {
            GetAuthor( email );

            if ( Utility.VerifyPassword( password, lists.authorList[ 0 ].password ))
            {
                return true;
            }
            return false;
        }

        public void UpdateAuthorProcedure(UpdateAuthorModel author, bool changedPassword = false)
        {

            AuthorService.UpdateAuthor( author.id, author.name, author.firstLastName, author.secondLastName, author.oldPassword, changedPassword, author.email, author.phone, author.description, author.avatar, author.preferedLanguage, author.isAdmin, author
                .canPublish, author.isActive, author.birthday, author.startDate, author.endDate );
        }

        public void DeleteAuthorProcedure(int id) 
        {
            AuthorService.DeleteAuthor( id );
        }

        public void FiltersViewBag
            (
                  int id = -1
                , string name = ""
                , string firstLastName = ""
                , string secondLastName = ""
                , string email = ""
                , sbyte isAdmin = -1
                , sbyte isActive = -1
                , string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                id = id,
                name = name,
                firstLastName = firstLastName,
                secondLastName = secondLastName,
                email = email,
                isAdmin = isAdmin,
                isActive = isActive,
                orderBy = orderBy
            };
        }
    }
}
