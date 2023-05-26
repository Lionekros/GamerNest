using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class WebTextService
    {
        public static List<WebTextModel> GetAllTexts(int id = -1, string title = "", int idCategory = -1, string language = "", string orderBy = "")
        {
            try
            {
                DataTable dt = WebTextRepository.GetAllTexts(id, title, idCategory, language, orderBy);
                List<WebTextModel> webTextList = new List<WebTextModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    webTextList.Add( new WebTextModel( row ) );
                }

                return webTextList;
            }
            catch ( Exception ex )
            {
                List<WebTextModel> webTextList = new List<WebTextModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return webTextList;

            }
        }

        public static List<WebTextModel> GetAllTextsByCategory(string category, string language = "ENG", string orderBy = "")
        {
            try
            {
                DataTable dt = WebTextRepository.GetAllTextsByCategory(category, language, orderBy);
                List<WebTextModel> webTextList = new List<WebTextModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    webTextList.Add( new WebTextModel( row ) );
                }

                return webTextList;
            }
            catch ( Exception ex )
            {
                List<WebTextModel> webTextList = new List<WebTextModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return webTextList;

            }
        }

        public static List<WebTextModel> GetText(int id)
        {
            try
            {
                DataTable dt = WebTextRepository.GetText(id);
                List<WebTextModel> list = new List<WebTextModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new WebTextModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<WebTextModel> list = new List<WebTextModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdateWebTextModel> GetTextUpdate(int id)
        {
            try
            {
                DataTable dt = WebTextRepository.GetText(id);
                List<UpdateWebTextModel> list = new List<UpdateWebTextModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateWebTextModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateWebTextModel> list = new List<UpdateWebTextModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateText(string title = "", string text = "", int idCategory = -1, string language = "")
        {

            WebTextRepository.CreateText( title, text, idCategory, language );
        }

        public static void UpdateText(int id = -1, string title = "", string text = "", int idCategory = -1, string language = "")
        {
            WebTextRepository.UpdateText( id, title, text, idCategory, language );
        }

        public static void DeleteText(int id = -1)
        {
            WebTextRepository.DeleteText( id );
        }
    }
}
