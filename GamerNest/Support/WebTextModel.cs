using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class WebTextModel
    {
        public int id { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string title { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string text { get; set; }

        [Required( ErrorMessage = "Required" )]
        public int idCategory { get; set; }
        public string category { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string language { get; set; }

        public List<CategoryModel>? categoryList { get; set; }

        public WebTextModel() { }

        public WebTextModel(DataRow row)
        {
            id = row.Field<int>( "wt.id" );
            title = row.Field<string>( "wt.title" );
            text = row.Field<string>( "wt.text" );
            idCategory = row.Field<int>( "wt.idCategory" );
            category = row.Field<string>( "cat.name" );
            language = row.Field<string>( "wt.language" );
        }
    }
}
