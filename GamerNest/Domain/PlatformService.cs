using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class PlatformService
    {
        public static List<GameExternalDataModel> GetAllPlatforms(string orderBy = "" )
        {
            try
            {
                DataTable dt = PlatformRepository.GetAllPlatforms(orderBy);

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
