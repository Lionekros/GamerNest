﻿using System.Data;

namespace Support
{
    public class UpdateUserModel
    {
        public int id { get; set; }
        public string username { get; set; }
        public string? password { get; set; }
        public string email { get; set; }
        public string? avatar { get; set; }
        public string preferedLanguage { get; set; }
        public string? creationDate { get; set; }

        public UpdateUserModel()
        { }

        public UpdateUserModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            username = row.Field<string>( "username" );
            password = row.Field<string>( "password" );
            email = row.Field<string>( "email" );
            preferedLanguage = row.Field<string>( "preferedLanguage" );
            avatar = row.Field<string>( "avatar" );
            creationDate = row.Field<string>( "creationDate" );
        }
    }

}
