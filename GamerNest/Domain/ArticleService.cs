using DBAccess;
using LogError;
using Support;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class ArticleService
    {
        public static List<ArticleModel> GetAllArticles(string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = -1, string orderBy = "", bool isFav = false, int user = -1)
        {
            try
            {
                DataTable dt = ArticleRepository.GetAllArticles(language, author, idGame, id, headline, isPublished, orderBy, isFav, user);
                List<ArticleModel> ArticleList = new List<ArticleModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    ArticleList.Add( new ArticleModel( row ) );
                }

                return ArticleList;
            }
            catch ( Exception ex )
            {
                List<ArticleModel> ArticleList = new List<ArticleModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return ArticleList;

            }
        }

        public static List<ArticleModel> GetArticle(int id)
        {
            try
            {
                DataTable dt = ArticleRepository.GetArticle(id);
                List<ArticleModel> list = new List<ArticleModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new ArticleModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<ArticleModel> list = new List<ArticleModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdateArticleModel> GetArticleUpdate(int id)
        {
            try
            {
                DataTable dt = ArticleRepository.GetArticle(id);
                List<UpdateArticleModel> list = new List<UpdateArticleModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateArticleModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateArticleModel> list = new List<UpdateArticleModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateArticle(string headline = "", string summary = "", string body = "", string cover = "", bool isPublished = false, string createdDate = "", int idAuthor = -1, string language = "", string updatedDate = "", List<int> idGame = null)
        {
            sbyte isPublished2 = Utility.BoolToSByte( isPublished );

            ArticleRepository.CreateArticle( headline, summary, body, cover, isPublished2, createdDate, idAuthor, language, updatedDate, idGame);
        }

        public static void UpdateArticle(int id = -1, string headline = "", string summary = "", string body = "", string cover = "", bool isPublished = false, string createdDate = "", int idAuthor = -1, string language = "", string updatedDate = "", List<int> idGame = null)
        {
            sbyte isPublished2 = Utility.BoolToSByte( isPublished );

            ArticleRepository.UpdateArticle( id, headline, summary, body, cover, isPublished2, createdDate, idAuthor, language, updatedDate, idGame );
        }

        public static void DeleteArticle(int id = -1)
        {
            ArticleRepository.DeleteArticle( id );
        }
    }
}
