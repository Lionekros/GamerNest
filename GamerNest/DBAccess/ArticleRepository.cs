using LogError;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class ArticleRepository
    {
        public static DataTable GetAllArticles(string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = -1, string orderBy = "", bool isFav = false, int user = -1)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT article.id, article.headline, article.summary, article.body, article.cover, article.isPublished, article.createdDate, article.updatedDate, article.idAuthor, author.email as 'author', author.canPublish as 'authorCanPublish', article.language" );
                    queryBuilder.Append( " FROM article, author" );

                    if ( idGame > 0 )
                    {
                        queryBuilder.Append( ", game_article, game" );
                        queryBuilder.Append( " WHERE article.idAuthor = author.id" );
                        queryBuilder.Append( " AND article.id = game_article.idArticle" );
                        queryBuilder.Append( " AND game_article.idGame = game.id" );
                        queryBuilder.Append( " AND game.id = " + idGame );
                    }
                    if ( isFav )
                    {
                        queryBuilder.Append( ", user, user_fav_game, game, game_article" );
                        queryBuilder.Append( " WHERE article.idAuthor = author.id" );
                        queryBuilder.Append( " AND user.id = user_fav_game.idUser" );
                        queryBuilder.Append( " AND user_fav_game.idGame = game.id" );
                        queryBuilder.Append( " AND game.id = game_article.idGame" );
                        queryBuilder.Append( " AND game_article.idArticle = article.id" );
                        queryBuilder.Append( " AND user_fav_game.idUser = " + user );
                    }
                    else
                    {
                        if ( idGame > 0 )
                        {
                            queryBuilder.Append( " AND article.idAuthor = author.id" );
                        }
                        else
                        {
                            queryBuilder.Append( " WHERE article.idAuthor = author.id" );
                        }

                    }

                    List<string> conditions = new List<string>();

                    if ( id > 0 )
                    {
                        conditions.Add( "article.id = " + id );
                    }

                    if ( !string.IsNullOrEmpty( headline ) )
                    {
                        conditions.Add( "LOWER(article.headline) LIKE '%" + headline.ToLower() + "%'" );
                    }

                    if ( !string.IsNullOrEmpty( author ) )
                    {
                        conditions.Add( "LOWER(author.email) LIKE '%" + author.ToLower() + "%'" );
                    }

                    if ( isPublished >= 0 )
                    {
                        conditions.Add( "article.isPublished = " + isPublished );
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

        public static DataTable GetArticle(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT article.id, article.headline, article.summary, article.body, article.cover, article.isPublished, article.createdDate, article.updatedDate, article.idAuthor, author.email as 'author', author.canPublish as 'authorCanPublish', article.language"
                                        + " FROM article, author"
                                        + " WHERE article.idAuthor = author.id AND article.id = " + id;
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

        public static int CreateArticle(string headline = "", string summary = "", string body = "", string cover = "", int isPublished = -1, string createdDate = "", int idAuthor = -1, string language = "", string updatedDate = "", List<int> idGame = null)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateArticle");

                procedure.Parameters.AddWithValue( "pHeadline", headline );
                procedure.Parameters.AddWithValue( "pSummary", summary );
                procedure.Parameters.AddWithValue( "pBody", body );
                procedure.Parameters.AddWithValue( "pCover", cover );
                procedure.Parameters.AddWithValue( "pIsPublished", isPublished );
                procedure.Parameters.AddWithValue( "pCreatedDate", createdDate );
                procedure.Parameters.AddWithValue( "pUpdatedDate", updatedDate );
                procedure.Parameters.AddWithValue( "pIdAuthor", idAuthor );
                procedure.Parameters.AddWithValue( "pLanguage", language );
                procedure.Parameters.AddWithValue( "pIdGame", string.Join( ",", idGame ) );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int UpdateArticle(int id = -1, string headline = "", string summary = "", string body = "", string cover = "", int isPublished = -1, string createdDate = "", int idAuthor = -1, string language = "", string updatedDate = "", List<int> idGame = null)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateArticle");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pHeadline", headline );
                procedure.Parameters.AddWithValue( "pSummary", summary );
                procedure.Parameters.AddWithValue( "pBody", body );
                procedure.Parameters.AddWithValue( "pCover", cover );
                procedure.Parameters.AddWithValue( "pIsPublished", isPublished );
                procedure.Parameters.AddWithValue( "pCreatedDate", createdDate );
                procedure.Parameters.AddWithValue( "pUpdatedDate", updatedDate );
                procedure.Parameters.AddWithValue( "pIdAuthor", idAuthor );
                procedure.Parameters.AddWithValue( "pLanguage", language );
                procedure.Parameters.AddWithValue( "pIdGame", string.Join( ",", idGame ) );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int DeleteArticle(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteArticle");

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
