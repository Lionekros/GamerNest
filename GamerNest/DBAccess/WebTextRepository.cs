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
    public class WebTextRepository
    {
        public static DataTable GetAllTexts(string language = "ENG", string orderBy = "", int limit = -1)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT wt.id, wt.title, wt.text, cat.name, wt.language"
                        + " FROM web_text wt, category cat"
                        + " WHERE wt.idCategory = cat.id"
                            + " AND wt.language = '" + language + "'";
                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        cmd.CommandText += " ORDER BY " + orderBy;
                    }
                    if ( limit > 0 )
                    {
                        cmd.CommandText += " LIMIT " + limit;
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

        public static DataTable GetAllTextsByCategory(string category, string language = "ENG", string orderBy = "", int limit = -1)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT wt.id AS 'wt.id', wt.title AS 'wt.title', wt.text AS 'wt.text', cat.name AS 'cat.name', wt.language AS 'wt.language'"
                        + " FROM web_text wt, category cat"
                        + " WHERE wt.idCategory = cat.id"
                            + " AND cAT.name = '" + category + "'"
                            + " AND wt.language = '" + language + "'";
                    if ( !string.IsNullOrEmpty( orderBy ) )
                    {
                        cmd.CommandText += " ORDER BY " + orderBy;
                    }
                    if ( limit > 0 )
                    {
                        cmd.CommandText += " LIMIT " + limit;
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
