using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class UpdateGenreTypeLanguageModel
    {
        [Required( ErrorMessage = "Required" )]
        public int id { get; set; }
        public string name { get; set; }
        public string language { get; set; }

        public UpdateGenreTypeLanguageModel()
        { }

        public UpdateGenreTypeLanguageModel(DataRow row)
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
