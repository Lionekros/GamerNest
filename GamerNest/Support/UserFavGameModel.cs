using System.Data;

namespace Support
{
    public class UserFavGameModel
    {
        public int idUser { get; set; }
        public int idGame { get; set; }

        public UserFavGameModel(DataRow row)
        {
            idUser = row.Field<int>( "idUser" );
            idGame = row.Field<int>( "idGame" );
        }
    }
}
