using DBAccess;
using LogError;
using Mysqlx.Crud;
using Support;
using System.Data;

namespace Domain
{
    public class PlayerTypeService
    {
        public static List<GameExternalDataModel> GetAllPlayerTypes(string language = "ENG", string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = PlayerTypeRepository.GetAllPlayerTypes(language, orderBy, limit);

                List<GameExternalDataModel> platerTypesList = new List<GameExternalDataModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    platerTypesList.Add( new GameExternalDataModel( row ) );
                }

                return platerTypesList;
            }
            catch ( Exception ex )
            {
                List<GameExternalDataModel> platerTypesList = new List<GameExternalDataModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return platerTypesList;

            }
        }
    }
}
