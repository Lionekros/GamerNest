using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class AdminLogIn
    {
        [Required( ErrorMessage = "Required" )]
        public string email { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string password { get; set; }

        public AdminLogIn()
        { }

        public AdminLogIn(DataRow row)
        {
            email = row.Field<string>( "email" );
            password = row.Field<string>( "password" );
        }


    }


}
