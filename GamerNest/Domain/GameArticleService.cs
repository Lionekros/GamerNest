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
    public class GameArticleService
    {
        public static List<GameArticleModel> GetAllGameArticles(long idGame, string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = GameArticleRepository.GetAllGameArticles(idGame, orderBy, limit);
                List<GameArticleModel> list = new List<GameArticleModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new GameArticleModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<GameArticleModel> list = new List<GameArticleModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }
    }
}
