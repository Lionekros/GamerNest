using LogError;
using MySql.Data.MySqlClient;
using System.Data;

namespace DBAccess
{
    public class PlatformRepository
    {
        public static DataTable GetAllPlatforms(string orderBy = "" )
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 3 as selector, id as idPlatform, name, icon"
                                + " FROM platform";
                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        cmd.CommandText += " ORDER BY " + orderBy;
                    }
                    return Data.ExecuteCommand( cmd );
                }
            }
            catch ( MySqlException ex )
            {
                DataTable dt = new DataTable();
                Log log = new Log();
                log.Add( ex.Message );
                return dt;
            }
        }
    }
}
