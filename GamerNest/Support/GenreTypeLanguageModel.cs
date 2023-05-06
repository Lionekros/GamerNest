using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class GenreTypeLanguageModel
    {
        public int id { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string name { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string language { get; set; }

        public GenreTypeLanguageModel()
        { }

        public GenreTypeLanguageModel(DataRow row)
        {
            string field = "id";

            long selector = row.Field<long>("selector");
            switch ( selector )
            {
                case 1:
                    field = "idGenre";
                    break;
                case 2:
                    field = "idLanguage";
                    break;
                case 4:
                    field = "idPlayerType";
                    break;
            }

            id = row.Field<int>( field );
            name = row.Field<string>( "name" );
            language = row.Field<string>( "language" );
        }
    }
}
