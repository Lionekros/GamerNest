using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UserLogInModel
    {
        
        [Required( ErrorMessage = "Required" )]
        public string username { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string? password { get; set; }

        public UserLogInModel()
        { }

        public UserLogInModel(DataRow row)
        {
            username = row.Field<string>( "username" );
            password = row.Field<string>( "password" );
        }
    }
}
