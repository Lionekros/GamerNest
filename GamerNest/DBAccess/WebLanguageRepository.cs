using LogError;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class WebLanguageRepository
    {
        public static DataTable GetAllWebLanguages
            (
                  string id = ""
                , string name = ""
                , string orderBy = ""
            )
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT id, name, icon" );
                    queryBuilder.Append( " FROM web_language" );

                    List<string> conditions = new List<string>();

                    if ( !string.IsNullOrEmpty( id ) )
                    {
                        conditions.Add( "LOWER(name) LIKE '%" + id.ToLower() + "%'" );
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

        public static DataTable GetWebLanguage(string id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT id, name, icon"
                        + " FROM web_language"
                        + " WHERE id = '" + id + "'";
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

        public static int CreateWebLanguage(string id = "", string name = "", string icon = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateWebLanguage");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pName", name );
                procedure.Parameters.AddWithValue( "pIcon", icon );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int UpdateWebLanguage(string id = "", string name = "", string icon = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateWebLanguage");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pName", name );
                procedure.Parameters.AddWithValue( "pIcon", icon );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int DeleteWebLanguage(string id = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteWebLanguage");

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
