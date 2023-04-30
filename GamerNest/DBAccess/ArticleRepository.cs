﻿using LogError;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DBAccess
{
    public class ArticleRepository
    {
        public static DataTable GetAllArticles(string language = "ENG", string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT id, headline, summary, body, cover, isPublished, createdDate, updatedDate, idAuthor, language"
                                + " FROM article"
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
