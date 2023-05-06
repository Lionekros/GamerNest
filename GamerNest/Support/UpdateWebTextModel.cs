using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class UpdateWebTextModel
    {
        [Required( ErrorMessage = "Required" )]
        public int id { get; set; }
        public string title { get; set; }
        public string text { get; set; }
        public int idCategory { get; set; }
        public string language { get; set; }

        public List<CategoryModel>? categoryList { get; set; }

        public UpdateWebTextModel() { }

        public UpdateWebTextModel(DataRow row)
        {
            id = row.Field<int>( "wt.id" );
            title = row.Field<string>( "wt.title" );
            text = row.Field<string>( "wt.text" );
            idCategory = row.Field<int>( "wt.idCategory" );
            language = row.Field<string>( "wt.language" );
        }
    }
}
