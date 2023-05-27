using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class UserService
    {
        public static List<UserModel> GetAllUsers
            (
                  int id = -1, string username = "", string email = "", string orderBy = ""
            )
        {
            try
            {
                DataTable dt = UserRepository.GetAllUsers(id, username, email, orderBy);
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

        public static List<UserModel> GetUser(int id = -1, string username = "", string email = "")
        {
            try
            {
                DataTable dt = UserRepository.GetUser(id, username, email);
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

        public static List<UpdateUserModel> GetUserUpdate(int id)
        {
            try
            {
                DataTable dt = UserRepository.GetUser(id);
                List<UpdateUserModel> list = new List<UpdateUserModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateUserModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateUserModel> list = new List<UpdateUserModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateUser
            (
                  string username = "",
                    string password = "",
                    string email = "",
                    string avatar = "",
                    string preferedLanguage = "",
                    string creationDate = ""
            )
        {
            creationDate = Utility.DateTimeToString( DateTime.Now.Date );
            password = Utility.EncriptPassword( password );

            UserRepository.CreateUser( username, password, email, avatar, preferedLanguage, creationDate );
        }

        public static void UpdateUser
            (
                    int id = -1
                    , string username = "",
                    bool changedPassword = false,
                    string password = "",
                    string email = "",
                    string avatar = "",
                    string preferedLanguage = "",
                    string creationDate = ""
            )
        {
            if ( changedPassword )
            {
                password = Utility.EncriptPassword( password );
            }

            UserRepository.UpdateUser( id, username, password, email, avatar, preferedLanguage, creationDate );
        }

        public static void DeleteUser(int id = -1)
        {
            UserRepository.DeleteUser( id );
        }
    }
}
