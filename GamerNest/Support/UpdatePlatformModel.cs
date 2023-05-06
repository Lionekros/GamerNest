using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UpdatePlatformModel
    {
        [Required( ErrorMessage = "Required" )]
        public int id { get; set; }
        public string name { get; set; }
        public string icon { get; set; }

        public UpdatePlatformModel() { }

        public UpdatePlatformModel(DataRow row)
        {
            id = row.Field<int>( id );
            name = row.Field<string>( "name" );
            icon = row.Field<string>( "icon" );
        }
    }
}
