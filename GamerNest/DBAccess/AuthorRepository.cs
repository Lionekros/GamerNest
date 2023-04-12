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
                , int       limit           = -1
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

                    if ( conditions.Count > 0 )
                    {
                        queryBuilder.Append( " WHERE " );
                        queryBuilder.Append( string.Join( " AND ", conditions ) );
                    }

                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        queryBuilder.Append( " ORDER BY " + orderBy );
                    }
                    if ( limit > 0 )
                    {
                        queryBuilder.Append( " LIMIT " + limit );
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
        public static DataTable GetAuthor(string email)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT id, name, firstLastName, secondLastName, password, email, phone, description, avatar, preferedLanguage, isAdmin, canPublish, isActive, birthday, startDate, endDate"
                        + " FROM author"
                        + " WHERE email = '" + email  + "'";
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
    }
}
