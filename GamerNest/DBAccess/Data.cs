using LogError;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;
using System.Data;

namespace DBAccess
{
    public class Data
    {
        public static MySqlCommand CreateCommand()
        {
            try
            {
                string conectionString = CreateConnection();
                MySqlConnection conection = new MySqlConnection(conectionString);
                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conection;
                cmd.CommandType = CommandType.Text;
                return cmd;
            }
            catch ( Exception ex )
            {
                MySqlCommand cmd = new MySqlCommand();
                Log log = new Log();
                log.Add( ex.Message );
                return cmd;
            }
        }

        public static DataTable ExecuteCommand(MySqlCommand cmd)
        {
            DataTable table = new DataTable();
            try
            {
                cmd.Connection.Open();
                MySqlDataAdapter adapter = new MySqlDataAdapter();
                adapter.SelectCommand = cmd;
                adapter.Fill( table );
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
                cmd.Connection.Close();
            }
            return table;
        }

        public static MySqlCommand CreateProcedure(string procedureName)
        {
            try
            {
                string conectionString = CreateConnection();
                MySqlConnection conection = new MySqlConnection(conectionString);
                MySqlCommand cmd = new MySqlCommand(procedureName, conection);
                cmd.CommandType = CommandType.StoredProcedure;
                return cmd;
            }
            catch ( Exception ex )
            {
                MySqlCommand cmd = new MySqlCommand();
                Log log = new Log();
                log.Add( ex.Message );
                return cmd;
            }
        }

        public static int ExecuteProcedure(MySqlCommand cmd)
        {
            try
            {
                cmd.Connection.Open();
                return cmd.ExecuteNonQuery();
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                return -1;
            }
            finally
            {
                cmd.Connection.Dispose();
                cmd.Connection.Close();
            }
        }

        public static string CreateConnection()
        {
            try
            {
                var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

                var db = builder.Build().GetSection("ConnectionStrings").GetSection("DemoDBConnectionString").Value;

                return db;
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
