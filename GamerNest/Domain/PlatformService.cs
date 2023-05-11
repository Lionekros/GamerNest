using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class PlatformService
    {
        public static List<PlatformModel> GetAllPlatforms(int id = -1, string name = "", string icon = "", string orderBy = "")
        {
            try
            {
                DataTable dt = PlatformRepository.GetAllPlatforms(id, name, icon, orderBy);
                List<PlatformModel> PlatformList = new List<PlatformModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    PlatformList.Add( new PlatformModel( row ) );
                }

                return PlatformList;
            }
            catch ( Exception ex )
            {
                List<PlatformModel> PlatformList = new List<PlatformModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return PlatformList;

            }
        }

        public static List<PlatformModel> GetPlatform(int id)
        {
            try
            {
                DataTable dt = PlatformRepository.GetPlatform(id);
                List<PlatformModel> list = new List<PlatformModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new PlatformModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<PlatformModel> list = new List<PlatformModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdatePlatformModel> GetPlatformUpdate(int id)
        {
            try
            {
                DataTable dt = PlatformRepository.GetPlatform(id);
                List<UpdatePlatformModel> list = new List<UpdatePlatformModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdatePlatformModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdatePlatformModel> list = new List<UpdatePlatformModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreatePlatform(string name = "", string icon = "")
        {

            PlatformRepository.CreatePlatform( name, icon );
        }

        public static void UpdatePlatform(int id = -1, string name = "", string icon = "")
        {
            PlatformRepository.UpdatePlatform( id, name, icon );
        }

        public static void DeletePlatform(int id = -1)
        {
            PlatformRepository.DeletePlatform( id );
        }
    }
}
