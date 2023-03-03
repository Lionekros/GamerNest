using System.Data;
using System.Data.SqlClient;
using LogError;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;

namespace DBAccess
{
    public class Data
    {
        public static MySqlCommand CrearComando()
        {
            try
            {
                string cadenaConexion = CreateConnection();
                MySqlConnection conexion = new MySqlConnection(cadenaConexion);
                MySqlCommand comando = new MySqlCommand();
                comando.Connection = conexion;
                comando.CommandType = CommandType.Text;
                return comando;
            }
            catch ( Exception ex )
            {
                MySqlCommand comando = new MySqlCommand();
                Log log = new Log();
                log.Add( ex.Message );
                return comando;
            }
        }

        public static MySqlCommand CrearComandoProc(string nombreProcedimiento)
        {
            try
            {
                string cadenaConexion = CreateConnection();
                MySqlConnection conexion = new MySqlConnection(cadenaConexion);
                MySqlCommand comando = new MySqlCommand(nombreProcedimiento, conexion);
                comando.CommandType = CommandType.StoredProcedure;
                return comando;
            }
            catch ( Exception ex )
            {
                MySqlCommand comando = new MySqlCommand();
                Log log = new Log();
                log.Add( ex.Message );
                return comando;
            }
        }

        public static int EjecutarComandoInsert(MySqlCommand comando)
        {
            try
            {
                comando.Connection.Open();
                return comando.ExecuteNonQuery();
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                return -1;
            }
            finally
            {
                comando.Connection.Dispose();
                comando.Connection.Close();
            }
        }

        public static DataTable EjecutarComandoSelect(MySqlCommand comando)
        {
            DataTable tabla = new DataTable();
            try
            {
                comando.Connection.Open();
                MySqlDataAdapter adaptador = new MySqlDataAdapter();
                adaptador.SelectCommand = comando;
                adaptador.Fill( tabla );
            }
            catch ( Exception ex )
            {
                DataTable dt = new DataTable();
                Log log = new Log();
                log.Add( ex.Message );
                return dt;
            }
            finally
            {
                comando.Connection.Close();
            }
            return tabla;
        }

        public static string CreateConnection()
        {
            try
            {
                var constructor = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

                var bbdd = constructor.Build().GetSection("ConnectionStrings").GetSection("DemoDBConnectionString").Value;

                return bbdd;
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                return "Error";
            }
        }

    }
}
