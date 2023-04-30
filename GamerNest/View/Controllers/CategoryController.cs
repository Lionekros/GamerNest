using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class CategoryController :MethodBaseController
    {
        public ActionResult Categories
            (
                   int page = 1
                , int pageSize = 10
                , int id = -1
                , string name = ""
                , string orderBy = ""
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
                GetAllCategories( id, name, orderBy );
                Pagination( page, pageSize );
                FiltersViewBag( id, name, orderBy );
                WebText( "AdminCategory" );
                return View( "Category", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminCategory" );
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
                WebText( "AdminCategoryForm" );
                return View( "CreateCategory" );
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
                if ( HttpContext.Session.GetString( "AdminType" ) != "Admin" )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultViewDatas();
                GetCategoryUpdate( id );
                UpdateCategoryModel category = lists.updateCategoryList[0];
                WebText( "AdminCategoryForm" );
                return View( "UpdateCategory", category );
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

        public ActionResult Create(CategoryModel category)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    CreateCategoryProcedure( category );
                    return RedirectToAction( "Categories" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();

                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminCategoryForm" );
                return View( "CreateCategory", category );
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

        public ActionResult Update(UpdateCategoryModel category)
        {

            try
            {
                WebText( "Messages" );

                List<string> errorMessageList = new List<string>();

                if ( ModelState.IsValid )
                {
                    UpdateCategoryProcedure( category );
                    return RedirectToAction( "Categories" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultViewDatas();
                ViewBag.ErrorMessages = errorMessageList;
                WebText( "AdminCategoryForm" );
                return View( "UpdateCategory", category );
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
            DeleteCategoryProcedure( id );
            return RedirectToAction( "Categories" );
        }

        public void Pagination(int page, int pageSize)
        {
            int totalCategory = lists.categoryList.Count;

            int skippedCategory = (page - 1) * pageSize;

            lists.categoryList = lists.categoryList.Skip( skippedCategory ).Take( pageSize ).ToList();

            lists.PageSize = pageSize;
            lists.CurrentPage = page;
            lists.TotalItems = totalCategory;
        }

        public void CreateCategoryProcedure(CategoryModel cat)
        {
            CategoryService.CreateCategory(cat.name);
        }

        public void UpdateCategoryProcedure(UpdateCategoryModel cat)
        {

            CategoryService.UpdateCategory( cat.id, cat.name );
        }

        public void DeleteCategoryProcedure(int id)
        {
            CategoryService.DeleteCategory( id );
        }

        public void FiltersViewBag
            (
                  int id = -1
                , string name = ""
                , string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                id = id,
                name = name,
                orderBy = orderBy
            };
        }
    }
}
