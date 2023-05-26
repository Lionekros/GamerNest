using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class PlatformModel
    {
        public int id { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string name { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string icon { get; set; }

        public PlatformModel() { }

        public PlatformModel(DataRow row)
        {
            id = row.Field<int>( id );
            name = row.Field<string>( "name" );
            icon = row.Field<string>( "icon" );
        }
    }
}
