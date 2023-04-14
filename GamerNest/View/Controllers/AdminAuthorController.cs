using Domain;
using Google.Protobuf.Collections;
using Microsoft.AspNetCore.Mvc;
using Mysqlx.Crud;
using Support;
using System.Xml.Linq;
using Support;
using LogError;
using static Mysqlx.Expect.Open.Types;
using MySqlX.XDevAPI;

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

        public ActionResult CreateAuthor(AuthorModel author)
        {
            try
            {
                List<string> errorMessageList = new List<string>();
                bool emailExist = false;
                bool phoneExist = false;

                if ( ModelState.IsValid )
                {
                    emailExist = EmailOrPhoneExist( author.email );
                    phoneExist = EmailOrPhoneExist( author.phone );

                    if ( emailExist )
                    {
                        errorMessageList.Add( "Email already in use" );
                    }

                    if ( phoneExist )
                    {
                        errorMessageList.Add( "Phone already in use" );
                    }

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

        public ActionResult CreateForm()
        {
            if ( HttpContext.Session.GetString( "AdminType" ) == null || HttpContext.Session.GetString( "AdminType" ) == "Author")
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            SetDefaultViewDatas();
            return View("CreateAuthor");
        }

        public ActionResult Create(AuthorModel author)
        {
            try
            {
                if ( ModelState.IsValid )
                {
                    ViewBag.Inserted = "Author inserted correctly";
                    return View("Authors");
                }
                else
                {
                    ViewBag.Message = "Fill all data";
                    return View( "CreateAuthor", author );
                }
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                ViewBag.ErrorTryCatch = "An error ocurred, try again later";
                return RedirectToAction( "Index", "Article" );
            }
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

        public bool EmailOrPhoneExist(string emailOrPhone)
        {
            GetAuthor( emailOrPhone );

            if ( lists.authorList.Count > 0 )
            {
                return true;
            }

            return false;

        }

        public void CreateAuthorProcedure(AuthorModel author)
        {
            AuthorService.CreateAuthor(author.name, author.firstLastName, author.secondLastName, author.password, author.email, author.phone, author.description, author.avatar, author.preferedLanguage, author.isAdmin, author
                .canPublish, author.isActive, author.birthday, author.startDate, author.endDate);
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
