using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class AuthorModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public string firstLastName { get; set; }
        public string secondLastName { get; set; }
        public string password { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string description { get; set; }
        public string avatar { get; set; }
        public sbyte isAdmin { get; set; }
        public sbyte canPublish { get; set; }
        public sbyte isActive { get; set; }
        public DateTime birthday { get; set; }
        public DateTime startDate { get; set; }
        public DateTime? endDate { get; set; }

        public AuthorModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            name = row.Field<string>( "name" );
            firstLastName = row.Field<string>( "firstLastName" );
            secondLastName = row.Field<string>( "secondLatName" );
            password = row.Field<string>( "password" );
            email = row.Field<string>( "email" );
            phone = row.Field<string>( "phone" );
            description = row.Field<string>( "description" );
            avatar = row.Field<string>( "avatar" );
            isAdmin = row.Field<sbyte>( "isAdmin" );
            canPublish = row.Field<sbyte>( "canPublish" );
            isActive = row.Field<sbyte>( "isActive" );
            birthday = row.Field<DateTime>( "birthday" );
            startDate = row.Field<DateTime>( "startDate" );
            endDate = row.Field<DateTime?>( "endDate" );
        }
    }
}
