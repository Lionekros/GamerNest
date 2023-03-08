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
        public long idGame { get; set; }
        public long idArticle { get; set; }

        public GameArticleModel(DataRow row)
        {
            idGame = row.Field<long>( "ididGame" );
            idArticle = row.Field<long>( "idArticle" );
        }
    }
}
