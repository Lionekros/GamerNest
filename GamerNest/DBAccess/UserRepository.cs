using LogError;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace DBAccess
{
    public class UserRepository
    {
        public static DataTable GetAllUsers(long id = -1, string username = "", string email = "", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT id, username, password, email, avatar, preferedLanguage, birthday, creationDate" );
                    queryBuilder.Append( " FROM user" );

                    List<string> conditions = new List<string>();

                    if ( id != -1 )
                    {
                        conditions.Add( "id = " + id );
                    }
                    if ( !string.IsNullOrEmpty( username ) )
                    {
                        conditions.Add( "LOWER(username) LIKE '%" + username.ToLower() + "%'" );
                    }
                    if ( !string.IsNullOrEmpty( email ) )
                    {
                        conditions.Add( "LOWER(email) LIKE '%" + email.ToLower() + "%'" );
                    }

                    if ( conditions.Count > 0 )
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

        public static DataTable GetUser(long id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT id, username, password, email, avatar, preferedLanguage, birthday, creationDate"
                        + " FROM user"
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

        public static int CreateUser
            (
                string username = "",
                string password = "",
                string email = "",
                string avatar = "",
                string preferedLanguage = "",
                string birthday = "",
                string creationDate = ""
            )
        {
            try
            {
                if (avatar == "")
                {
                    avatar = "/img/Avatar/User/Default.png";
                }
                MySqlCommand procedure = Data.CreateProcedure("CreateUser");

                procedure.Parameters.AddWithValue( "pUsername", username );
                procedure.Parameters.AddWithValue( "pPassword", password );
                procedure.Parameters.AddWithValue( "pEmail", email );
                procedure.Parameters.AddWithValue( "pAvatar", avatar );
                procedure.Parameters.AddWithValue( "pPreferedLanguage", preferedLanguage );
                procedure.Parameters.AddWithValue( "pBirthday", birthday );
                procedure.Parameters.AddWithValue( "pCreationDate", creationDate );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                return -1;
            }
        }

        public static int UpdateUser
                (
                      long id = -1
                    , string username = "",
                    string password = "",
                    string email = "",
                    string avatar = "",
                    string preferedLanguage = "",
                    string birthday = "",
                    string creationDate = ""
                )
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateUser");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pUsername", username );
                procedure.Parameters.AddWithValue( "pPassword", password );
                procedure.Parameters.AddWithValue( "pEmail", email );
                procedure.Parameters.AddWithValue( "pAvatar", avatar );
                procedure.Parameters.AddWithValue( "pPreferedLanguage", preferedLanguage );
                procedure.Parameters.AddWithValue( "pBirthday", birthday );
                procedure.Parameters.AddWithValue( "pCreationDate", creationDate );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int DeleteUser(long id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteUser");

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

//        SELECT game.id as 'game.id', game.cover as 'game.cover', game.title as 'game.title', game.subtitle as 'game.subtitle', platform.name as 'platform.name ', platform.icon as 'platform.icon'
//FROM user, user_fav_game, game, platform
//WHERE user.id = user_fav_game.idUser
//AND user_fav_game.idGame = game.id
//AND game.idPlatform = platform.id
//and user_fav_game.idUser = 1
    }
}
