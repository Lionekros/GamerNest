using DBAccess;
using LogError;
using Mysqlx.Crud;
using Support;
using System.Data;

namespace Domain
{
    public class PublisherService
    {
        public static List<GameExternalDataModel> GetAllPublishers(string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = PublisherRepository.GetAllPublishers(orderBy, limit);

                List<GameExternalDataModel> publisherList = new List<GameExternalDataModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    publisherList.Add( new GameExternalDataModel( row ) );
                }

                return publisherList;
            }
            catch ( Exception ex )
            {
                List<GameExternalDataModel> publisherList = new List<GameExternalDataModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return publisherList;

            }
        }
    }
}
