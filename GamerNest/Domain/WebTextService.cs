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
    public class WebTextService
    {
        public static List<WebTextModel> GetAllTexts(string language = "ENG", string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = WebTextRepository.GetAllTexts(language, orderBy, limit);
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

        public static List<WebTextModel> GetAllTextsByCategory(string category, string language = "ENG", string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = WebTextRepository.GetAllTextsByCategory(category, language, orderBy, limit);
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
    }
}
