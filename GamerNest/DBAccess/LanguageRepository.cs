using LogError;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class LanguageRepository
    {
        public static DataTable GetAllLanguages(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT 2 AS selector, language.id AS idLanguage, language.name, language.language" );
                    queryBuilder.Append( " FROM language" );

                    List<string> conditions = new List<string>();

                    if ( id != -1 )
                    {
                        conditions.Add( "language.id = " + id );
                    }

                    if ( !string.IsNullOrEmpty( name ) )
                    {
                        conditions.Add( "LOWER(language.name) LIKE '%" + name.ToLower() + "%'" );
                    }

                    if ( !string.IsNullOrEmpty( language ) )
                    {
                        conditions.Add( "LOWER(language.language) LIKE '%" + language.ToLower() + "%'" );
                    }

                    if ( idGame > 0 )
                    {
                        queryBuilder.Append( ", game_language gpt" );
                        conditions.Add( "language.id = gpt.idLanguage AND gpt.idGame = " + idGame );
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

        public static DataTable GetLanguage(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 2 AS selector, language.id AS idLanguage, language.name, language.language"
                                        + " FROM language"
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

        public static int CreateLanguage(string name = "", string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateLanguage");

                procedure.Parameters.AddWithValue( "pName", name );
                procedure.Parameters.AddWithValue( "pLanguage", language );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int UpdateLanguage(int id = -1, string name = "", string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateLanguage");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pName", name );
                procedure.Parameters.AddWithValue( "pLanguage", language );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int DeleteLanguage(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteLanguage");

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
