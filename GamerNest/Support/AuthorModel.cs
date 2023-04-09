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
        public string preferedLanguage { get; set; }
        public bool isAdmin { get; set; }
        public bool canPublish { get; set; }
        public bool isActive { get; set; }
        public string birthday { get; set; }
        public string startDate { get; set; }
        public string endDate { get; set; }

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
