using System.Data;

namespace Support
{
    public class UserScoreGameModel
    {
        public int idUser { get; set; }
        public int idGame { get; set; }
        public sbyte score { get; set; }

        public UserScoreGameModel(DataRow row)
        {
            idUser = row.Field<int>( "idUser" );
            idGame = row.Field<int>( "idGame" );
            score = row.Field<sbyte>( "score" );
        }
    }
}
