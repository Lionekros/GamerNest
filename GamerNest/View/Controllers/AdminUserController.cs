﻿using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;
using System.Text.RegularExpressions;

namespace View.Controllers
{
    public class AdminUserController :MethodBaseController
    {
        public ActionResult Users
            (
                  int page = 1
                , int pageSize = 10,
                  long id = -1, string username = "", string email = "", string orderBy = ""
            )
        {
            try
            {
                SetDefaultViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                else if ( HttpContext.Session.GetString( "AdminType" ) != "Admin" )
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
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultViewDatas();
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

        public ActionResult UpdateForm(long id)
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) != "Admin" )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultViewDatas();
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
                    model.avatar = UploadImage( avatar, model.id, "Avatar", "User", "avatar" );
                    CreateUserProcedure( model );
                    return RedirectToAction( "Users" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

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
                SetDefaultViewDatas();
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

        public ActionResult Delete(long id)
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

        public void DeleteUserProcedure(long id)
        {
            UserService.DeleteUser( id );
        }

        public void FiltersViewBag
            (
                 long id = -1, string username = "", string email = "", string orderBy = ""
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
