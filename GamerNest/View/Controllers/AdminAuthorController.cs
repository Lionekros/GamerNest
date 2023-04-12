using Domain;
using Google.Protobuf.Collections;
using Microsoft.AspNetCore.Mvc;
using Mysqlx.Crud;
using Support;

namespace View.Controllers
{
    public class AdminAuthorController :BaseController
    {
        public ActionResult Authors
            (
                  int       page            = 1
                , int       pageSize        = 10
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

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }
            GetAllAuthors( id, name, firstLastName, secondLastName, email, isAdmin, isActive, orderBy );
            Pagination(page, pageSize);

            return View( "Authors", lists );
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

        private void Pagination(int page, int pageSize)
        {
            int totalAuthors = lists.authorList.Count;

            int skippedAuthors = (page - 1) * pageSize;

            lists.authorList = lists.authorList.Skip( skippedAuthors ).Take( pageSize ).ToList();

            lists.PageSize = pageSize;
            lists.CurrentPage = page;
            lists.TotalItems = totalAuthors;
        }
    }
}
