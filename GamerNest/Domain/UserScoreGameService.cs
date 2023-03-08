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
    public class UserScoreGameService
    {
        public static List<UserScoreGameModel> GetAllScores(long idUser, long idGame, string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = UserScoreGameRepository.GetAllScores(idUser, idGame, orderBy, limit);
                List<UserScoreGameModel> list = new List<UserScoreGameModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UserScoreGameModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UserScoreGameModel> list = new List<UserScoreGameModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }
    }
}
