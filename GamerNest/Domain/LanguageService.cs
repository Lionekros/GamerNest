using DBAccess;
using LogError;
using Mysqlx.Crud;
using Support;
using System.Data;

namespace Domain
{
    public class LanguageService
    {
        public static List<GameExternalDataModel> GetAllLanguages(string language = "ENG", string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = LanguageRepository.GetAllLanguages(language, orderBy, limit);

                List<GameExternalDataModel> languageList = new List<GameExternalDataModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    languageList.Add( new GameExternalDataModel( row ) );
                }

                return languageList;
            }
            catch ( Exception ex )
            {
                List<GameExternalDataModel> languageList = new List<GameExternalDataModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return languageList;

            }
        }
    }
}
