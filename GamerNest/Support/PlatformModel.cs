using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
