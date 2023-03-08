using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UserModel
    {
        public long Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Email { get; set; }
        public string Avatar { get; set; }
        public bool IsConfirmed { get; set; }
        public DateTime Birthday { get; set; }
        public DateTime CreationDate { get; set; }
        public string Token { get; set; }

        public UserModel()
        {
            // Default constructor
        }

        public UserModel(DataRow row)
        {
            Id = row.Field<long>( "id" );
            Username = row.Field<string>( "username" );
            Password = row.Field<string>( "password" );
            Email = row.Field<string>( "email" );
            Avatar = row.Field<string>( "avatar" );
            IsConfirmed = row.Field<bool>( "isConfirmed" );
            Birthday = row.Field<DateTime>( "birthday" );
            CreationDate = row.Field<DateTime>( "creationDate" );
            Token = row.Field<string>( "token" );
        }
    }

}
