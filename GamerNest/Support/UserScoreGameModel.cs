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
        public long idUser { get; set; }
        public long idGame { get; set; }
        public sbyte score { get; set; }

        public UserScoreGameModel(DataRow row) 
        {
            idUser = row.Field<long>( "idUser" );
            idGame = row.Field<long>( "idGame" );
            score = row.Field<sbyte>( "score" );
        }
    }
}
