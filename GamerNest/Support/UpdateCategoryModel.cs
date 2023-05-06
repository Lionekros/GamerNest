using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UpdateCategoryModel
    {
        [Required( ErrorMessage = "Required" )]
        public int id { get; set; }
        public string name { get; set; }

        public UpdateCategoryModel()
        {
        }

        public UpdateCategoryModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            name = row.Field<string>( "name" );
        }
    }
}
