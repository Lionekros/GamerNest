using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UserPageModel
    {
        public int? id { get; set; }
        
        public string? username { get; set; }
        
        public string? email { get; set; }
        public string? avatar { get; set; }
        
        public string? preferedLanguage { get; set; }
        
        public string? creationDate { get; set; }

        public string? oldPassword { get; set; }
        public string? newPassword { get; set; }
        public string? confirmPassword { get; set; }

        public UserPageModel()
        { 
        }

        public UserPageModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            username = row.Field<string>( "username" );
            oldPassword = row.Field<string>( "password" );
            email = row.Field<string>( "email" );
            avatar = row.Field<string>( "avatar" );
            preferedLanguage = row.Field<string>( "preferedLanguage" );
            creationDate = row.Field<string>( "creationDate" );
        }
    }
}
