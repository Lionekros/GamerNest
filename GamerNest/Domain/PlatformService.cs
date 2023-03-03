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
        public static List<PlatformModel> GetPlatforms()
        {
            try
            {
                DataTable dt = PlatformRepository.GetPlatforms();

                List<PlatformModel> platformList = new List<PlatformModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    platformList.Add( new PlatformModel( row ) );
                }

                return platformList;
            }
            catch ( Exception ex )
            {
                List<PlatformModel> listaPlataforma = new List<PlatformModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return listaPlataforma;

            }
        }
    }
}
