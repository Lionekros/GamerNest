using LogError;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;

namespace DBAccess
{
    public class WebTextRepository
    {
        public static DataTable GetAllTexts(int id = -1, string title = "", int idCategory = -1, string language = "", string orderBy = "wt.id")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append( "SELECT wt.id AS 'wt.id', wt.title AS 'wt.title', wt.text AS 'wt.text', wt.idCategory AS 'wt.idCategory', cat.name AS 'cat.name', wt.language AS 'wt.language'" );
                    queryBuilder.Append( " FROM web_text wt, category cat" );
                    queryBuilder.Append( " WHERE wt.idCategory = cat.id" );

                    if ( id != -1 )
                    {
                        queryBuilder.Append( " AND wt.id = " + id );
                    }
                    if ( !string.IsNullOrEmpty( title ) )
                    {
                        queryBuilder.Append( " AND LOWER(wt.title) LIKE '%" + title.ToLower() + "%'" );
                    }
                    if ( idCategory != -1 )
                    {
                        queryBuilder.Append( " AND wt.idCategory = " + idCategory );
                    }
                    if ( !string.IsNullOrEmpty( language ) )
                    {
                        queryBuilder.Append( " AND LOWER(wt.language) = '" + language.ToLower() + "'" );
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

        public static DataTable GetAllTextsByCategory(string category, string language = "ENG", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT wt.id AS 'wt.id', wt.title AS 'wt.title', wt.text AS 'wt.text', wt.idCategory AS 'wt.idCategory', cat.name AS 'cat.name', wt.language AS 'wt.language'"
                        + " FROM web_text wt, category cat"
                        + " WHERE wt.idCategory = cat.id"
                            + " AND cat.name = '" + category + "'"
                            + " AND wt.language = '" + language + "'";
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

        public static DataTable GetText(int id)
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT wt.id AS 'wt.id', wt.title AS 'wt.title', wt.text AS 'wt.text', wt.idCategory AS 'wt.idCategory', wt.language AS 'wt.language'"
                        + " FROM web_text wt"
                        + " WHERE wt.id = '" + id + "'";
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

        public static int CreateText(string title = "", string text = "", int idCategory = -1, string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("CreateWebText");

                procedure.Parameters.AddWithValue( "pTitle", title );
                procedure.Parameters.AddWithValue( "pText", text );
                procedure.Parameters.AddWithValue( "pIdCategory", idCategory );
                procedure.Parameters.AddWithValue( "pLanguage", language );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int UpdateText(int id = -1, string title = "", string text = "", int idCategory = -1, string language = "")
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("UpdateWebText");

                procedure.Parameters.AddWithValue( "pId", id );
                procedure.Parameters.AddWithValue( "pTitle", title );
                procedure.Parameters.AddWithValue( "pText", text );
                procedure.Parameters.AddWithValue( "pIdCategory", idCategory );
                procedure.Parameters.AddWithValue( "pLanguage", language );

                return Data.ExecuteProcedure( procedure );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                return -1;

            }
        }

        public static int DeleteText(int id = -1)
        {
            try
            {
                MySqlCommand procedure = Data.CreateProcedure("DeleteWebText");

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
