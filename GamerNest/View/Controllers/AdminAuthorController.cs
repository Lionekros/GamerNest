using Domain;
using Google.Protobuf.Collections;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminAuthorController :BaseController
    {
        public ActionResult Authors(int page = 1, int pageSize = 10)
        {
            SetDefaultViewDatas();

            if ( HttpContext.Session.GetString( "AdminEmail" ) == null )
            {
                return RedirectToAction( "LogInForm", "Admin" );
            }

            GetAllAuthors();

            Pagination(page, pageSize);

            return View( "Authors", lists );
        }


        public void GetAllAuthors()
        {
            lists.authorList = AuthorService.GetAllAuthors( "id" );
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
