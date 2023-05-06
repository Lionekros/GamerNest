using LogError;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class PublisherRepository
    {

        public static DataTable GetAllPublishers(int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT 5 as selector, id as idPublisher, name" );
                    queryBuilder.Append( " FROM publisher" );

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

        public static DataTable GetPublisher(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 5 as selector, id as idPublisher, name"
                                + " FROM publisher"
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

        public static int CreatePublisher(string name = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreatePublisher");

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

        public static int UpdatePublisher(int id = -1, string name = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdatePublisher");

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

        public static int DeletePublisher(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeletePublisher");

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
