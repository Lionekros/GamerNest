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
        public static DataTable GetAllGames(string language = "", string user = "", long idArticle = -1, int id = -1, string title = "", string subtitle = "", string orderBy = "")
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
                        queryBuilder.Append( " AND user.username = " + user );
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

                    if ( !string.IsNullOrEmpty( language ) )
                    {
                        conditions.Add( "LOWER(article.language) LIKE '%" + language.ToLower() + "%'" );
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
                                        + " game.idPlatform = platform.id"
                                        + " AND id = " + id;

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

        public static DataTable GetGameScore(int idArticle = -1, string user = "", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "game.id, game.title, game.subtitle, game.cover, game.totalScore, game.idPlatform, platform.name as 'platform', platform.icon as 'platformIcon', user_score_game.score as 'score', user.username as 'username'" );
                    queryBuilder.Append( " game, platform, user_score_game, user" );
                    queryBuilder.Append( " WHERE game.idPlatform = platform.id" );
                    queryBuilder.Append( " AND game.id = user_score_game.idGame" );
                    queryBuilder.Append( " AND user_score_game.idUser = user.id" );

                    if ( idArticle > 0 )
                    {
                        queryBuilder.Append( " AND user_score_game.idGame = " + idArticle );
                    }
                    else if ( !string.IsNullOrEmpty( user ) )
                    {
                        queryBuilder.Append( " AND user.username = " + user );
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

        //public static int CreateGame(string headline = "", string summary = "", string body = "", string cover = "", int isPublished = -1, string createdDate = "", int idAuthor = -1, string language = "", string updatedDate = "", List<int> idGenre = null)
        //{
        //    try
        //    {
        //        MySqlCommand procedure = Data.CreateProcedure("CreateGame");

        //        procedure.Parameters.AddWithValue( "pHeadline", headline );
        //        procedure.Parameters.AddWithValue( "pSummary", summary );
        //        procedure.Parameters.AddWithValue( "pBody", body );
        //        procedure.Parameters.AddWithValue( "pCover", cover );
        //        procedure.Parameters.AddWithValue( "pIsPublished", isPublished );
        //        procedure.Parameters.AddWithValue( "pCreatedDate", createdDate );
        //        procedure.Parameters.AddWithValue( "pUpdatedDate", updatedDate );
        //        procedure.Parameters.AddWithValue( "pIdAuthor", idAuthor );
        //        procedure.Parameters.AddWithValue( "pLanguage", language );
        //        procedure.Parameters.AddWithValue( "pIdGame", string.Join( ",", idGame ) );

        //        return Data.ExecuteProcedure( procedure );
        //    }
        //    catch ( Exception ex )
        //    {

        //        Log log = new Log();
        //        log.Add( ex.Message );
        //        return -1;

        //    }
        //}

        //public static int UpdateGame(long id = -1, string headline = "", string summary = "", string body = "", string cover = "", int isPublished = -1, string createdDate = "", int idAuthor = -1, string language = "", string updatedDate = "", List<long> idGame = null)
        //{
        //    try
        //    {
        //        MySqlCommand procedure = Data.CreateProcedure("UpdateGame");

        //        procedure.Parameters.AddWithValue( "pId", id );
        //        procedure.Parameters.AddWithValue( "pHeadline", headline );
        //        procedure.Parameters.AddWithValue( "pSummary", summary );
        //        procedure.Parameters.AddWithValue( "pBody", body );
        //        procedure.Parameters.AddWithValue( "pCover", cover );
        //        procedure.Parameters.AddWithValue( "pIsPublished", isPublished );
        //        procedure.Parameters.AddWithValue( "pCreatedDate", createdDate );
        //        procedure.Parameters.AddWithValue( "pUpdatedDate", updatedDate );
        //        procedure.Parameters.AddWithValue( "pIdAuthor", idAuthor );
        //        procedure.Parameters.AddWithValue( "pLanguage", language );
        //        procedure.Parameters.AddWithValue( "pIdGame", string.Join( ",", idGame ) );

        //        return Data.ExecuteProcedure( procedure );
        //    }
        //    catch ( Exception ex )
        //    {

        //        Log log = new Log();
        //        log.Add( ex.Message );
        //        return -1;

        //    }
        //}

        //public static int DeleteGame(int id = -1)
        //{
        //    try
        //    {
        //        MySqlCommand procedure = Data.CreateProcedure("DeleteGame");

        //        procedure.Parameters.AddWithValue( "pId", id );

        //        return Data.ExecuteProcedure( procedure );
        //    }
        //    catch ( Exception ex )
        //    {

        //        Log log = new Log();
        //        log.Add( ex.Message );
        //        return -1;

        //    }
        //}
    }
}
