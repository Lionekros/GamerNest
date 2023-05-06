using DBAccess;
using LogError;
using Mysqlx.Crud;
using Support;
using System.Data;

namespace Domain
{
    public class PublisherService
    {
        public static List<DevPublisherModel> GetAllPublishers(int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                DataTable dt = PublisherRepository.GetAllPublishers(id, name, orderBy);
                List<DevPublisherModel> PublisherList = new List<DevPublisherModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    PublisherList.Add( new DevPublisherModel( row ) );
                }

                return PublisherList;
            }
            catch ( Exception ex )
            {
                List<DevPublisherModel> PublisherList = new List<DevPublisherModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return PublisherList;

            }
        }

        public static List<DevPublisherModel> GetPublisher(int id)
        {
            try
            {
                DataTable dt = PublisherRepository.GetPublisher(id);
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

        public static List<UpdateDevPublisherModel> GetPublisherUpdate(int id)
        {
            try
            {
                DataTable dt = PublisherRepository.GetPublisher(id);
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

        public static void CreatePublisher(string name = "")
        {

            PublisherRepository.CreatePublisher( name );
        }

        public static void UpdatePublisher(int id = -1, string name = "")
        {
            PublisherRepository.UpdatePublisher( id, name );
        }

        public static void DeletePublisher(int id = -1)
        {
            PublisherRepository.DeletePublisher( id );
        }
    }
}
