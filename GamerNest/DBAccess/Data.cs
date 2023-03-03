using System.Data;
using System.Data.SqlClient;
using LogError;
using Microsoft.Extensions.Configuration;

namespace DBAccess
{
    internal class Data
    {
        public static SqlCommand CrearComando()
        {
            try
            {
                string cadenaConexion = CreateConnection();
                SqlConnection conexion = new SqlConnection();
                conexion.ConnectionString = cadenaConexion;
                SqlCommand comando = new SqlCommand();
                comando = conexion.CreateCommand();
                comando.CommandType = CommandType.Text;
                return comando;
            }
            catch ( Exception ex )
            {
                SqlCommand comando = new SqlCommand();
                Log log = new Log();
                log.Add( ex.Message );
                return comando;
            }
        }

        public static SqlCommand CrearComandoProc(string nombreProcedimiento)
        {
            try
            {
                string cadenaConexion = CreateConnection();
                SqlConnection conexion = new SqlConnection(cadenaConexion);
                SqlCommand comando = new SqlCommand(nombreProcedimiento, conexion);
                comando.CommandType = CommandType.StoredProcedure;
                return comando;
            }
            catch ( Exception ex )
            {
                SqlCommand comando = new SqlCommand();
                Log log = new Log();
                log.Add( ex.Message );
                return comando;
            }
        }

        public static int EjecutarComandoInsert(SqlCommand comando)
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

        public static DataTable EjecutarComandoSelect(SqlCommand comando)
        {
            DataTable tabla = new DataTable();
            try
            {
                comando.Connection.Open();
                SqlDataAdapter adaptador = new SqlDataAdapter();
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
            { comando.Connection.Close(); }
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
