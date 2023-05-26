﻿using LogError;
using MySql.Data.MySqlClient;
using System.Data;

namespace DBAccess
{
    public class GameArticleRepository
    {
        public static DataTable GetAllGameArticles(int idGame, string orderBy = "")
        {
            try
            {
                using ( MySqlCommand cmd = Data.CreateCommand() )
                {
                    cmd.CommandText = cmd.CommandText = "SELECT idGame, idArticle"
                                + " FROM game_article"
                                + " WHERE idGame = " + idGame;
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
