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
    public class UserService
    {
        public static List<UserModel> GetAllGames(string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = UserRepository.GetAllUsers(orderBy, limit);
                List<UserModel> list = new List<UserModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UserModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UserModel> list = new List<UserModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }
    }
}
