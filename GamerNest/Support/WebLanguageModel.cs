using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class WebLanguageModel
    {
        [Required( ErrorMessage = "Required" )]
        public string id { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string name { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string icon { get; set; }

        public WebLanguageModel()
        {
        }

    public WebLanguageModel(DataRow row)
        {
            id = row.Field<string>( "id" );
            name = row.Field<string>( "name" );
            icon = row.Field<string>( "icon" );
        }
    }
}
