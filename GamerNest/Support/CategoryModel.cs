using System.Data;

namespace Support
{
    public class CategoryModel
    {
        public int id { get; set; }
        public string name { get; set; }

        public CategoryModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            name = row.Field<string>( "name" );
        }
    }
}
