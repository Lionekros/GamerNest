using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class DevService
    {
        public static List<DevPublisherModel> GetAllDevs(int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                DataTable dt = DevRepository.GetAllDevs(id, name, orderBy);
                List<DevPublisherModel> DevList = new List<DevPublisherModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    DevList.Add( new DevPublisherModel( row ) );
                }

                return DevList;
            }
            catch ( Exception ex )
            {
                List<DevPublisherModel> DevList = new List<DevPublisherModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return DevList;

            }
        }

        public static List<DevPublisherModel> GetDev(int id)
        {
            try
            {
                DataTable dt = DevRepository.GetDev(id);
                List<DevPublisherModel> list = new List<DevPublisherModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new DevPublisherModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<DevPublisherModel> list = new List<DevPublisherModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdateDevPublisherModel> GetDevUpdate(int id)
        {
            try
            {
                DataTable dt = DevRepository.GetDev(id);
                List<UpdateDevPublisherModel> list = new List<UpdateDevPublisherModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateDevPublisherModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateDevPublisherModel> list = new List<UpdateDevPublisherModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateDev(string name = "")
        {

            DevRepository.CreateDev( name );
        }

        public static void UpdateDev(int id = -1, string name = "")
        {
            DevRepository.UpdateDev( id, name );
        }

        public static void DeleteDev(int id = -1)
        {
            DevRepository.DeleteDev( id );
        }
    }
}
