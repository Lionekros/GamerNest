using LogError;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class PlayerTypeRepository
    {
        public static DataTable GetAllPlayerTypes(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT 4 AS selector, player_type.id AS idPlayerType, player_type.name, player_type.language" );
                    queryBuilder.Append( " FROM player_type" );

                    List<string> conditions = new List<string>();

                    if ( id != -1 )
                    {
                        conditions.Add( "player_type.id = " + id );
                    }

                    if ( !string.IsNullOrEmpty( name ) )
                    {
                        conditions.Add( "LOWER(player_type.name) LIKE '%" + name.ToLower() + "%'" );
                    }

                    if ( !string.IsNullOrEmpty( language ) )
                    {
                        conditions.Add( "LOWER(player_type.language) LIKE '%" + language.ToLower() + "%'" );
                    }

                    if ( idGame > 0 )
                    {
                        queryBuilder.Append( ", game_player_type gpt" );
                        conditions.Add( "player_type.id = gpt.idPlayerType AND gpt.idGame = " + idGame );
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




        public static DataTable GetPlayerType(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 4 as selector, id as idPlayerType, name, language"
                                        + " FROM player_type"
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

        public static int CreatePlayerType(string name = "", string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreatePlayerType");

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

        public static int UpdatePlayerType(int id = -1, string name = "", string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdatePlayerType");

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

        public static int DeletePlayerType(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeletePlayerType");

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
