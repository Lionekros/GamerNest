using LogError;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using System.Data;

namespace DBAccess
{
    public class LanguageRepository
    {
        public static DataTable GetAllLanguages(string language = "ENG", string orderBy = "" )
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = "SELECT 2 as selector, id as idLanguage, name, language"
                                 + " FROM language"
                                 + " WHERE language = '" + language + "'";
                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        cmd.CommandText += " ORDER BY " + orderBy;
                    }
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
