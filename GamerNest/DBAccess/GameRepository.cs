using LogError;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBAccess
{
    public class GameRepository
    {
        public static DataTable GetAllGames(string language = "", string user = "", int idArticle = -1, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT game.id, game.title, game.subtitle, game.description, game.language, game.cover, game.releaseDate, game.totalScore, game.isFav, game.idDev, dev.name as 'dev', game.idPlatform, platform.name as 'platform', platform.icon as 'platformIcon', game.idPublisher, publisher.name as 'publisher'" );
                    queryBuilder.Append( " FROM game, dev, publisher, platform" );

                    if ( idArticle > 0 )
                    {
                        queryBuilder.Append( ", game_article, article" );
                        queryBuilder.Append( " WHERE game.idDev = dev.id" );
                        queryBuilder.Append( " AND game.idPlatform = platform.id" );
                        queryBuilder.Append( " AND game.idPublisher = publisher.id" );
                        queryBuilder.Append( " AND article.id = game_article.idArticle" );
                        queryBuilder.Append( " AND game_article.idGame = game.id" );
                        queryBuilder.Append( " AND article.id = " + idArticle );
                    }
                    else if ( !string.IsNullOrEmpty( user ) )
                    {
                        queryBuilder.Append( ", user_fav_game, user" );
                        queryBuilder.Append( " WHERE game.idDev = dev.id" );
                        queryBuilder.Append( " AND game.idPlatform = platform.id" );
                        queryBuilder.Append( " AND game.idPublisher = publisher.id" );
                        queryBuilder.Append( " AND game.id = user_fav_game.idGame" );
                        queryBuilder.Append( " AND user_fav_game.idUser = user.id" );
                        queryBuilder.Append( " AND user.username = '" + user + "'");
                    }
                    else
                    {
                        queryBuilder.Append( " WHERE game.idDev = dev.id" );
                        queryBuilder.Append( " AND game.idPlatform = platform.id" );
                        queryBuilder.Append( " AND game.idPublisher = publisher.id" +
                            "" );
                    }

                    List<string> conditions = new List<string>();

                    if ( id > 0 )
                    {
                        conditions.Add( "game.id = " + id );
                    }

                    if ( !string.IsNullOrEmpty( title ) )
                    {
                        conditions.Add( "LOWER(game.title) LIKE '%" + title.ToLower() + "%'" );
                    }
                    if ( !string.IsNullOrEmpty( subtitle ) )
                    {
                        conditions.Add( "LOWER(game.subtitle) LIKE '%" + subtitle.ToLower() + "%'" );
                    }

                    if (idPlatform > 0)
                    {
                        conditions.Add( "game.idPlatform = " + idPlatform );
                    }

                    if ( !string.IsNullOrEmpty( language ) )
                    {
                        conditions.Add( "LOWER(game.language) LIKE '%" + language.ToLower() + "%'" );
                    }

                    if ( conditions?.Count > 0 )
                    {
                        queryBuilder.Append( " AND " );
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

        public static DataTable GetGame(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT game.id, game.title, game.subtitle, game.description, game.language, game.cover, game.releaseDate, game.totalScore, game.isFav, game.idDev, dev.name as 'dev', game.idPlatform, platform.name as 'platform', platform.icon as 'platformIcon', game.idPublisher, publisher.name as 'publisher'"
                                        + " FROM game, dev, publisher, platform"
                                        + " WHERE game.idDev = dev.id"
                                        + " AND game.idPublisher = publisher.id"
                                        + " AND game.idPlatform = platform.id"
                                        + " AND game.id = " + id;

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

        public static DataTable CheckIfFav(int idUser = -1, int idGame = -1)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT idUser, idGame"
                                        + " FROM user_fav_game"
                                        + " WHERE idUser = " + idUser
                                        + " AND idGame = " + idGame;

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

        public static DataTable GetGameScore(string language = "", string user = "", int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT game.id, game.title, game.subtitle, game.description, game.language, game.cover, game.releaseDate, game.totalScore, game.isFav, game.idDev, dev.name as 'dev', game.idPlatform, platform.name as 'platform', platform.icon as 'platformIcon', game.idPublisher, publisher.name as 'publisher', user_score_game.score as 'score'" );
                    queryBuilder.Append( " FROM game, dev, publisher, platform, user_score_game, user" );

                    if ( id > 0 )
                    {
                        queryBuilder.Append( " WHERE game.idDev = dev.id" );
                        queryBuilder.Append( " AND game.idPlatform = platform.id" );
                        queryBuilder.Append( " AND game.idPublisher = publisher.id" );
                        queryBuilder.Append( " AND game.id = user_score_game.idGame" );
                        queryBuilder.Append( " AND user_score_game.idUser = user.id" );
                        queryBuilder.Append( " AND user_score_game.idGame = " + id );
                    }
                    else
                    {
                        queryBuilder.Append( " WHERE game.idDev = dev.id" );
                        queryBuilder.Append( " AND game.idPlatform = platform.id" );
                        queryBuilder.Append( " AND game.idPublisher = publisher.id" );
                        queryBuilder.Append( " AND game.id = user_score_game.idGame" );
                        queryBuilder.Append( " AND user_score_game.idUser = user.id" );
                        queryBuilder.Append( " AND user.username = '" + user + "'" );
                    }

                    List<string> conditions = new List<string>();

                    if ( !string.IsNullOrEmpty( title ) )
                    {
                        conditions.Add( "LOWER(game.title) LIKE '%" + title.ToLower() + "%'" );
                    }
                    if ( !string.IsNullOrEmpty( subtitle ) )
                    {
                        conditions.Add( "LOWER(game.subtitle) LIKE '%" + subtitle.ToLower() + "%'" );
                    }

                    if ( !string.IsNullOrEmpty( language ) )
                    {
                        conditions.Add( "LOWER(game.language) LIKE '%" + language.ToLower() + "%'" );
                    }

                    if ( idPlatform > 0 )
                    {
                        conditions.Add( "game.idPlatform = " + idPlatform );
                    }

                    if ( conditions?.Count > 0 )
                    {
                        queryBuilder.Append( " AND " );
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

        public static long CreateGame(string title = "", string subtitle = "", string description = "", string language = "", string cover = "/img/Cover/Game/Default.png", string releaseDate = "", sbyte totalScore = 0, sbyte isFav = 0, int idDev = -1, int idPlatform = -1, int idPublisher = -1, List<int> idGenre = null, List<int> idPlayerType = null, List<int> idLanguageGame = null)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateGame");

                procedure.Parameters.AddWithValue( "pTitle", title );
                procedure.Parameters.AddWithValue( "pSubtitle", subtitle );
                procedure.Parameters.AddWithValue( "pDescription", description );
                procedure.Parameters.AddWithValue( "pLanguage", language );
                procedure.Parameters.AddWithValue( "pCover", cover );
                procedure.Parameters.AddWithValue( "pReleaseDate", releaseDate );
                procedure.Parameters.AddWithValue( "pTotalScore", totalScore );
                procedure.Parameters.AddWithValue( "pIsFav", isFav );
                procedure.Parameters.AddWithValue( "pIdDev", idDev );
                procedure.Parameters.AddWithValue( "pIdPlatform", idPlatform );
                procedure.Parameters.AddWithValue( "pIdPublisher", idPublisher );
                procedure.Parameters.AddWithValue( "pIdGenre", string.Join( ",", idGenre ) );
                procedure.Parameters.AddWithValue( "pIdPlayerType", string.Join( ",", idPlayerType ) );
                procedure.Parameters.AddWithValue( "pIdLanguage", string.Join( ",", idLanguageGame ) );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                return -1;
            }
        }


        public static long UpdateGame(int id = -1, string title = "", string subtitle = "", string description = "", string language = "", string cover = "", string releaseDate = "", sbyte totalScore = 0, sbyte isFav = 0, int idDev = -1, int idPlatform = -1, int idPublisher = -1, List<int> idGenre = null, List<int> idPlayerType = null, List<int> idLanguageGame = null)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateGame");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pTitle", title );
                procedure.Parameters.AddWithValue( "pSubtitle", subtitle );
                procedure.Parameters.AddWithValue( "pDescription", description );
                procedure.Parameters.AddWithValue( "pLanguage", language );
                procedure.Parameters.AddWithValue( "pCover", cover );
                procedure.Parameters.AddWithValue( "pReleaseDate", releaseDate );
                procedure.Parameters.AddWithValue( "pTotalScore", totalScore );
                procedure.Parameters.AddWithValue( "pIsFav", isFav );
                procedure.Parameters.AddWithValue( "pIdDev", idDev );
                procedure.Parameters.AddWithValue( "pIdPlatform", idPlatform );
                procedure.Parameters.AddWithValue( "pIdPublisher", idPublisher );
                procedure.Parameters.AddWithValue( "pIdGenre", string.Join( ",", idGenre ) );
                procedure.Parameters.AddWithValue( "pIdPlayerType", string.Join( ",", idPlayerType ) );
                procedure.Parameters.AddWithValue( "pIdLanguage", string.Join( ",", idLanguageGame ) );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {
                Log log = new Log();
                log.Add( ex.Message );
                return -1;
            }
        }


        public static long DeleteGame(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteGame");

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
