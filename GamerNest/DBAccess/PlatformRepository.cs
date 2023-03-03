
using LogError;
using MySql.Data.MySqlClient;
using System.Data;
using System.Data.SqlClient;

namespace DBAccess
{
    public class PlatformRepository
    {
        public static DataTable GetPlatforms()
        {
            try
            {
                MySqlCommand cmd = Data.CreateCommand();
                cmd.CommandText = "SELECT 4 as selector, id as idPlatform, name"
                                + " FROM platform";
                return Data.ExecuteCommand( cmd );
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
