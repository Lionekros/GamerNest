using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class AuthorModel
    {
        [Required( ErrorMessage = "Required" )]
        public int id { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string name { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string firstLastName { get; set; }
        public string? secondLastName { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string password { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string email { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string phone { get; set; }
        public string? description { get; set; }
        public string? avatar { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string preferedLanguage { get; set; }

        [Required( ErrorMessage = "Required" )]
        public bool isAdmin { get; set; }

        [Required( ErrorMessage = "Required" )]
        public bool canPublish { get; set; }

        [Required( ErrorMessage = "Required" )]
        public bool isActive { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string birthday { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string startDate { get; set; }
        public string? endDate { get; set; }

        public AuthorModel()
        {
        }

        public AuthorModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            name = row.Field<string>( "name" );
            firstLastName = row.Field<string>( "firstLastName" );
            secondLastName = row.Field<string>( "secondLastName" );
            password = row.Field<string>( "password" );
            email = row.Field<string>( "email" );
            phone = row.Field<string>( "phone" );
            description = row.Field<string>( "description" );
            avatar = row.Field<string>( "avatar" );
            preferedLanguage = row.Field<string>( "preferedLanguage" );
            isAdmin = Utility.sByteToBool( row.Field<sbyte>( "isAdmin" ) );
            canPublish = Utility.sByteToBool( row.Field<sbyte>( "canPublish" ));
            isActive = Utility.sByteToBool( row.Field<sbyte>( "isActive" ));
            birthday = Utility.DateTimeToString( row.Field<DateTime>( "birthday" ));
            startDate = Utility.DateTimeToString( row.Field<DateTime>( "startDate" ));
            if ( row[ "endDate" ] != DBNull.Value )
                endDate = Utility.DateTimeToString( row.Field<DateTime>( "endDate" ) );
            else
                endDate = "";
        }
    }
}
