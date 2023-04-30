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
    public class UserFavGameService
    {
        public static List<UserFavGameModel> GetAllFavs(long idUser, long idGame, string orderBy = "" )
        {
            try
            {
                DataTable dt = UserFavGameRepository.GetAllFavs(idUser, idGame, orderBy);
                List<UserFavGameModel> list = new List<UserFavGameModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UserFavGameModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UserFavGameModel> list = new List<UserFavGameModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }
    }
}
