using LogError;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class DevRepository
    {
        public static DataTable GetAllDevs(int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT 0 as selector, id as idDev, name" );
                    queryBuilder.Append( " FROM dev" );

                    List<string> conditions = new List<string>();

                    if ( id != -1 )
                    {
                        conditions.Add( "id = " + id );
                    }

                    if ( !string.IsNullOrEmpty( name ) )
                    {
                        conditions.Add( "LOWER(name) LIKE '%" + name.ToLower() + "%'" );
                    }

                    if ( conditions?.Count > 0 )
                    {
                        queryBuilder.Append( " WHERE " );
                        queryBuilder.Append( string.Join( " AND ", conditions ) );
                    }

                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        queryBuilder.Append( " ORDER BY " + orderBy );
                    }

                    cmd.CommandText = queryBuilder.ToString();
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

        public static DataTable GetDev(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 0 as selector, id as idDev, name"
                                + " FROM dev"
                                + " WHERE id = " + id;
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

        public static int CreateDev(string name = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateDev");

                procedure.Parameters.AddWithValue( "pName", name );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int UpdateDev(int id = -1, string name = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateDev");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pName", name );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int DeleteDev(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteDev");

                procedure.Parameters.AddWithValue( "pId", id );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }
    }
}
