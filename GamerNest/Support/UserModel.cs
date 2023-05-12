﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UserModel
    {
        public long id { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string username { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string password { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string email { get; set; }
        public string avatar { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string preferedLanguage { get; set; }
        [Required( ErrorMessage = "Required" )]
        public string birthday { get; set; }
        public string? creationDate { get; set; }

        public UserModel()
        { }

        public UserModel(DataRow row)
        {
            id = row.Field<long>( "id" );
            username = row.Field<string>( "username" );
            password = row.Field<string>( "password" );
            email = row.Field<string>( "email" );
            avatar = row.Field<string>( "avatar" );
            preferedLanguage = row.Field<string>( "preferedLanguage" );
            birthday = row.Field<string>( "birthday" );
            creationDate = row.Field<string>( "creationDate" );
        }
    }

}
