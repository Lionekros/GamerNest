using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class DevService
    {
        public static List<GameExternalDataModel> GetAllDevs(string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = DevRepository.GetAllDevs(orderBy, limit);
                List<GameExternalDataModel> platformList = new List<GameExternalDataModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    platformList.Add( new GameExternalDataModel( row ) );
                }

                return platformList;
            }
            catch ( Exception ex )
            {
                List<GameExternalDataModel> platformList = new List<GameExternalDataModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return platformList;

            }
        }
    }
}
