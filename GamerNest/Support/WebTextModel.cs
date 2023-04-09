using System.Data;

namespace Support
{
    public class WebTextModel
    {
        public int id { get; set; }
        public string title { get; set; }
        public string text { get; set; }
        public string category { get; set; }
        public string language { get; set; }

        public WebTextModel(DataRow row)
        {
            id = row.Field<int>( "wt.id" );
            title = row.Field<string>( "wt.title" );
            text = row.Field<string>( "wt.text" );
            category = row.Field<string>( "cat.name" );
            language = row.Field<string>( "wt.language" );
        }
    }
}
