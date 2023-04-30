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
    public class GameService
    {
        public static List<GameModel> GetAllGames(string language = "ENG", string orderBy = "" )
        {
            try
            {
                DataTable dt = GameRepository.GetAllGames(language, orderBy);
                List<GameModel> list = new List<GameModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new GameModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<GameModel> list = new List<GameModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }
    }
}
