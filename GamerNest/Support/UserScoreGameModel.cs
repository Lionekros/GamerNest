using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
