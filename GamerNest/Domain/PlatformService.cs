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
    public class PlatformService
    {
        public static List<GameExternalDataModel> GetPlatforms()
        {
            try
            {
                DataTable dt = PlatformRepository.GetPlatforms();

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
