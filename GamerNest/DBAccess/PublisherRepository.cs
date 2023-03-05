using LogError;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using System.Data;

namespace DBAccess
{
    public class PublisherRepository
    {
        public static DataTable GetAllPublishers(string orderBy = "", int limit = -1)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 5 as selector, id as idPublisher, name"
                                + " FROM publisher";
                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        cmd.CommandText += " ORDER BY " + orderBy;
                    }
                    if ( limit > 0 )
                    {
                        cmd.CommandText += " LIMIT " + limit;
                    }
                    return Data.ExecuteCommand( cmd );
                }
            }
            catch ( Exception ex )
            {
                DataTable dt = new DataTable();
                Log log = new Log();
                log.Add( ex.Message );
                return dt;
            }

        }
    }
}
