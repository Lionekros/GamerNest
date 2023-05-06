using LogError;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBAccess
{
    public class AuthorRepository
    {
        public static DataTable GetAllAuthors
            (
                  int       id              = -1
                , string    name            = ""
                , string    firstLastName   = ""
                , string    secondLastName  = ""
                , string    email           = ""
                , sbyte     isAdmin         = -1
                , sbyte     isActive        = -1
                , string    orderBy         = ""
            )
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT id, name, firstLastName, secondLastName, password, email, phone, description, avatar, preferedLanguage, isAdmin, canPublish, isActive, birthday, startDate, endDate" );
                    queryBuilder.Append( " FROM author" );

                    List<string> conditions = new List<string>();

                    if ( id != -1 )
                    {
                        conditions.Add( "id = " + id );
                    }
                    if ( !string.IsNullOrEmpty( name ) )
                    {
                        conditions.Add( "LOWER(name) LIKE '%" + name.ToLower() + "%'" );
                    }
                    if ( !string.IsNullOrEmpty( firstLastName ) )
                    {
                        conditions.Add( "LOWER(firstLastName) LIKE '%" + firstLastName.ToLower() + "%'" );
                    }
                    if ( !string.IsNullOrEmpty( secondLastName ) )
                    {
                        conditions.Add( "LOWER(secondLastName) LIKE '%" + secondLastName.ToLower() + "%'" );
                    }
                    if ( !string.IsNullOrEmpty( email ) )
                    {
                        conditions.Add( "LOWER(email) LIKE '%" + email.ToLower() + "%'" );
                    }
                    if ( isAdmin != -1 )
                    {
                        conditions.Add( "isAdmin = '" + isAdmin + "'" );
                    }
                    if ( isActive != -1 )
                    {
                        conditions.Add( "isActive = '" + isActive + "'" );
                    }

                    if ( conditions?.Count > 0 )
                    {
                        queryBuilder.Append( " WHERE " );
                        queryBuilder.Append( string.Join( " AND ", conditions ) );
                    }

                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        queryBuilder.Append( " ORDER BY " + orderBy );
                    }

                    cmd.CommandText = queryBuilder.ToString();
                    return Data.ExecuteCommand( cmd );
                }
            }
            catch ( MySqlException ex )
            {
                DataTable dt = new DataTable();
                Log log = new Log();
                log.Add( ex.Message );
                return dt;
            }

        }
        public static DataTable GetAuthor(string emailOrPhone)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT id, name, firstLastName, secondLastName, password, email, phone, description, avatar, preferedLanguage, isAdmin, canPublish, isActive, birthday, startDate, endDate"
                        + " FROM author"
                        + " WHERE email = '" + emailOrPhone  + "' OR phone = '" + emailOrPhone + "'";
                    return Data.ExecuteCommand( cmd );
                }

            }
            catch ( MySqlException ex )
            {
                DataTable dt = new DataTable();
                Log log = new Log();
                log.Add( ex.Message );
                return dt;
            }

        }

        public static int CreateAuthor
            (
                  string    name                = ""
                , string    firstLastName       = ""
                , string    secondLastName      = ""
                , string    password            = ""
                , string    email               = ""
                , string    phone               = ""
                , string    description         = ""
                , string    avatar              = ""
                , string    preferedLanguage    = ""
                , sbyte     isAdmin             = -1
                , sbyte     canPublish          = -1
                , sbyte     isActive            = -1
                , string    birthday            = ""
                , string    startDate           = ""
                , string    endDate             = ""
            )
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateAuthor");

                procedure.Parameters.AddWithValue( "pName", name );
                procedure.Parameters.AddWithValue( "pFirstLastName", firstLastName );
                procedure.Parameters.AddWithValue( "pSecondLastName", secondLastName );
                procedure.Parameters.AddWithValue( "pPassword", password );
                procedure.Parameters.AddWithValue( "pEmail", email );
                procedure.Parameters.AddWithValue( "pPhone", phone );
                procedure.Parameters.AddWithValue( "pDescription", description );
                procedure.Parameters.AddWithValue( "pAvatar", avatar );
                procedure.Parameters.AddWithValue( "pPreferedLanguage", preferedLanguage );
                procedure.Parameters.AddWithValue( "pIsAdmin", isAdmin );
                procedure.Parameters.AddWithValue( "pCanPublish", canPublish );
                procedure.Parameters.AddWithValue( "pIsActive", isActive );
                procedure.Parameters.AddWithValue( "pBirthday", birthday );
                procedure.Parameters.AddWithValue( "pStartDate", startDate );
                procedure.Parameters.AddWithValue( "pEndDate", endDate );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int UpdateAuthor
            (
                  int       id                  = -1
                , string    name                = ""
                , string    firstLastName       = ""
                , string    secondLastName      = ""
                , string    password            = ""
                , string    email               = ""
                , string    phone               = ""
                , string    description         = ""
                , string    avatar              = ""
                , string    preferedLanguage    = ""
                , sbyte     isAdmin             = -1
                , sbyte     canPublish          = -1
                , sbyte     isActive            = -1
                , string    birthday            = ""
                , string    startDate           = ""
                , string    endDate             = ""
            )
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateAuthor");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pName", name );
                procedure.Parameters.AddWithValue( "pFirstLastName", firstLastName );
                procedure.Parameters.AddWithValue( "pSecondLastName", secondLastName );
                procedure.Parameters.AddWithValue( "pPassword", password );
                procedure.Parameters.AddWithValue( "pEmail", email );
                procedure.Parameters.AddWithValue( "pPhone", phone );
                procedure.Parameters.AddWithValue( "pDescription", description );
                procedure.Parameters.AddWithValue( "pAvatar", avatar );
                procedure.Parameters.AddWithValue( "pPreferedLanguage", preferedLanguage );
                procedure.Parameters.AddWithValue( "pIsAdmin", isAdmin );
                procedure.Parameters.AddWithValue( "pCanPublish", canPublish );
                procedure.Parameters.AddWithValue( "pIsActive", isActive );
                procedure.Parameters.AddWithValue( "pBirthday", birthday );
                procedure.Parameters.AddWithValue( "pStartDate", startDate );
                procedure.Parameters.AddWithValue( "pEndDate", endDate );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int DeleteAuthor(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteAuthor");

                procedure.Parameters.AddWithValue( "pId", id );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }
    }
}
