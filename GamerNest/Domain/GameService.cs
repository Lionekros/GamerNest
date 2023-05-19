using DBAccess;
using LogError;
using Support;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class GameService
    {
        public static List<GameModel> GetAllGames(string language = "", string user = "", long idArticle = -1, int id = -1, string title = "", string subtitle = "", string orderBy = "")
        {
            try
            {
                DataTable dt = GameRepository.GetAllGames(language, user, idArticle, id, title, subtitle, orderBy);
                List<GameModel> GameList = new List<GameModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    GameList.Add( new GameModel( row ) );
                }

                return GameList;
            }
            catch ( Exception ex )
            {
                List<GameModel> GameList = new List<GameModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return GameList;

            }
        }

        public static List<GameModel> GetGame(int id)
        {
            try
            {
                DataTable dt = GameRepository.GetGame(id);
                List<GameModel> list = new List<GameModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new GameModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<GameModel> list = new List<GameModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<GameScoreModel> GetGameScore(int idArticle = -1, string user = "", string orderBy = "")
        {
            try
            {
                DataTable dt = GameRepository.GetGameScore(idArticle, user, orderBy);
                List<GameScoreModel> GameList = new List<GameScoreModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    GameList.Add( new GameScoreModel( row ) );
                }

                return GameList;
            }
            catch ( Exception ex )
            {
                List<GameScoreModel> GameList = new List<GameScoreModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return GameList;

            }
        }

        public static List<UpdateGameModel> GetGameUpdate(int id)
        {
            try
            {
                DataTable dt = GameRepository.GetGame(id);
                List<UpdateGameModel> list = new List<UpdateGameModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateGameModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateGameModel> list = new List<UpdateGameModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateGame(string title = "", string subtitle = "", string description = "", string language = "", string cover = "", string releaseDate = "", sbyte totalScore = 0, bool isFav = false, int idDev = -1, int idPlatform = -1, int idPublisher = -1, List<int> idGenre = null, List<int> idPlayerType = null, List<int> idLanguageGame = null)
        {
            sbyte isFav2 = Utility.BoolToSByte(isFav);

            GameRepository.CreateGame( title, subtitle, description, language, cover, releaseDate, totalScore, isFav2, idDev, idPlatform, idPublisher, idGenre, idPlayerType, idLanguageGame);
        }

        public static void UpdateGame(long id = -1, string title = "", string subtitle = "", string description = "", string language = "", string cover = "", string releaseDate = "", sbyte totalScore = 0, bool isFav = false, int idDev = -1, int idPlatform = -1, int idPublisher = -1, List<int> idGenre = null, List<int> idPlayerType = null, List<int> idLanguageGame = null)
        {
            sbyte isFav2 = Utility.BoolToSByte(isFav);

            GameRepository.UpdateGame( id, title, subtitle, description, language, cover, releaseDate, totalScore, isFav2, idDev, idPlatform, idPublisher, idGenre, idPlayerType, idLanguageGame );
        }

        public static void DeleteGame(long id = -1)
        {
            GameRepository.DeleteGame( id );
        }
    }
}
