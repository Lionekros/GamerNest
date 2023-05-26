using LogError;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class GenreRepository
    {
        public static DataTable GetAllGenres(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT 1 as selector, genre.id as idGenre, genre.name, genre.language" );
                    queryBuilder.Append( " FROM genre" );

                    List<string> conditions = new List<string>();

                    if ( id != -1 )
                    {
                        conditions.Add( "genre.id = " + id );
                    }

                    if ( !string.IsNullOrEmpty( name ) )
                    {
                        conditions.Add( "LOWER(genre.name) LIKE '%" + name.ToLower() + "%'" );
                    }

                    if ( !string.IsNullOrEmpty( language ) )
                    {
                        conditions.Add( "LOWER(genre.genre) LIKE '%" + language.ToLower() + "%'" );
                    }

                    if ( idGame > 0 )
                    {
                        queryBuilder.Append( ", game_genre gpt" );
                        conditions.Add( "genre.id = gpt.idGenre AND gpt.idGame = " + idGame );
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

        public static DataTable GetGenre(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 1 as selector, genre.id as idGenre, genre.name, genre.language"
                                        + " FROM genre"
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

        public static int CreateGenre(string name = "", string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateGenre");

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

        public static int UpdateGenre(int id = -1, string name = "", string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateGenre");

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

        public static int DeleteGenre(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteGenre");

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
