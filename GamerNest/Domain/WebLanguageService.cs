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
    public class WebLanguageService
    {
        public static List<WebLanguageModel> GetAllWebLanguages
            (
                  string id = ""
                , string name = ""
                , string orderBy = ""
            )
        {
            try
            {
                DataTable dt = WebLanguageRepository.GetAllWebLanguages(id, name, orderBy);
                List<WebLanguageModel> list = new List<WebLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new WebLanguageModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<WebLanguageModel> list = new List<WebLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<WebLanguageModel> GetWebLanguage(string id)
        {
            try
            {
                DataTable dt = WebLanguageRepository.GetWebLanguage(id);
                List<WebLanguageModel> list = new List<WebLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new WebLanguageModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<WebLanguageModel> list = new List<WebLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdateWebLanguageModel> GetWebLanguageUpdate(string emailOrPhone)
        {
            try
            {
                DataTable dt = WebLanguageRepository.GetWebLanguage(emailOrPhone);
                List<UpdateWebLanguageModel> list = new List<UpdateWebLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateWebLanguageModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateWebLanguageModel> list = new List<UpdateWebLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateWebLanguage
            (
                  string id = ""
                , string name = ""
                , string icon = ""
            )
        {

            WebLanguageRepository.CreateWebLanguage( id, name, icon );
        }

        public static void UpdateWebLanguage
            (
                  string id = ""
                , string name = ""
                , string icon = ""
            )
        {
            WebLanguageRepository.UpdateWebLanguage( id, name, icon );
        }

        public static void DeleteWebLanguage(string id = "")
        {
            WebLanguageRepository.DeleteWebLanguage( id );
        }
    }
    
}
