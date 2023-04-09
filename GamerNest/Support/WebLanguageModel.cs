using System.Data;

namespace Support
{
    public class WebLanguageModel
    {
        public string id { get; set; }
        public string name { get; set; }
        public string icon { get; set; }

        public WebLanguageModel(DataRow row)
        {
            id = row.Field<string>( "id" );
            name = row.Field<string>( "name" );
            icon = row.Field<string>( "icon" );
        }
    }
}
