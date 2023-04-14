﻿using Domain;
using Microsoft.AspNetCore.Mvc;
using Support;
using LogError;

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


                return View( "Authors", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
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
                return View( "CreateAuthor" );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
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
                GetAuthor( email );
                AuthorModel author = lists.authorList[0];
                return View( "UpdateAuthor", author );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult Create(AuthorModel author, IFormFile avatar)
        {
            try
            {
                List<string> errorMessageList = new List<string>();
                bool emailExist = false;
                bool phoneExist = false;

                if ( ModelState.IsValid )
                {
                    emailExist = EmailOrPhoneExist( author.email, author.id );
                    phoneExist = EmailOrPhoneExist( author.phone, author.id );

                    if ( emailExist )
                    {
                        errorMessageList.Add( "Email already in use" );
                    }

                    if ( phoneExist )
                    {
                        errorMessageList.Add( "Phone already in use" );
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
                    errorMessageList.Add( "Fill all required data" );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                return View( "CreateAuthor", author );
            }
            catch ( Exception ex )
            {
                
                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Update(AuthorModel author, IFormFile avatar) 
        {
            try
            {
                List<string> errorMessageList = new List<string>();
                bool emailExist = false;
                bool phoneExist = false;
                bool confirmPass = false;
                bool changedPassword = false;

                if ( ModelState.IsValid )
                {
                    emailExist = EmailOrPhoneExist( author.email, author.id );
                    phoneExist = EmailOrPhoneExist( author.phone, author.id );

                    if ( emailExist )
                    {
                        errorMessageList.Add( "Email already in use" );
                    }

                    if ( phoneExist )
                    {
                        errorMessageList.Add( "Phone already in use" );
                    }

                    author.avatar = UploadImage( avatar, author.id, "Avatar", "Author" );

                    if ( HttpContext.Session.GetString( "AdminType" ) == "Author" )
                    {
                        if ( CheckPasswordAuthor( author.email, author.oldPassword ) )
                        {
                            if ( ConfirmPassword( author.newPassword, author.confirmPassword ) )
                            {
                                author.password = author.newPassword;
                                changedPassword = true;
                                confirmPass = true;
                            }
                            else
                            {
                                errorMessageList.Add( "New password and Confirm password don't match" );
                            }
                        }
                        else
                        {
                            errorMessageList.Add( "Incorrect Old Password" );
                        }

                        if ( !emailExist && !phoneExist && confirmPass )
                        {
                            UpdateAuthorProcedure( author, changedPassword );
                            return RedirectToAction( "Authors" );
                        }
                    }

                    if ( !emailExist && !phoneExist)
                    {
                        UpdateAuthorProcedure( author );
                        return RedirectToAction( "Authors" );
                    }
                }
                else
                {
                    errorMessageList.Add( "Fill all required data" );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                return View( "UpdateAuthor", author );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
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

        public void UpdateAuthorProcedure(AuthorModel author, bool changedPassword = false)
        {

            AuthorService.UpdateAuthor( author.id, author.name, author.firstLastName, author.secondLastName, author.password, changedPassword, author.email, author.phone, author.description, author.avatar, author.preferedLanguage, author.isAdmin, author
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