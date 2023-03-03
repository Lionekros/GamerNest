
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
                MySqlCommand cmd = Data.CrearComando();
                cmd.CommandText = "SELECT id, platform"
                                + " FROM platforms";
                return Data.EjecutarComandoSelect( cmd );
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
