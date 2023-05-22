using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class GameArticleModel
    {
        public int idGame { get; set; }
        public int idArticle { get; set; }

        public GameArticleModel(DataRow row)
        {
            idGame = row.Field<int>( "ididGame" );
            idArticle = row.Field<int>( "idArticle" );
        }
    }
}
