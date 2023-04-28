using DBAccess;
using LogError;
using Support;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class CategoryService
    {
        public static List<CategoryModel> GetAllCategories
            (
                  int id = -1
                , string name = ""
                , string orderBy = ""
                , int limit = -1
            )
        {
            try
            {
                DataTable dt = CategoryRepository.GetAllCategories(id, name, orderBy, limit);
                List<CategoryModel> list = new List<CategoryModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new CategoryModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<CategoryModel> list = new List<CategoryModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<CategoryModel> GetCategory(int id)
        {
            try
            {
                DataTable dt = CategoryRepository.GetCategory(id);
                List<CategoryModel> list = new List<CategoryModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new CategoryModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<CategoryModel> list = new List<CategoryModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdateCategoryModel> GetCategoryUpdate(int id)
        {
            try
            {
                DataTable dt = CategoryRepository.GetCategory(id);
                List<UpdateCategoryModel> list = new List<UpdateCategoryModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateCategoryModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateCategoryModel> list = new List<UpdateCategoryModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateCategory
            (
                   string name = ""
            )
        {

            CategoryRepository.CreateCategory(name);
        }

        public static void UpdateCategory
            (
                  int id = -1
                , string name = ""
            )
        {
            CategoryRepository.UpdateCategory( id, name );
        }

        public static void DeleteCategory(int id = -1)
        {
            CategoryRepository.DeleteCategory( id );
        }
    }
}
