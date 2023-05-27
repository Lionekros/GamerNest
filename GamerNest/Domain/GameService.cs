using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class GameService
    {
        public static List<GameModel> GetAllGames(string language = "", string user = "", int idArticle = -1, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "")
        {
            try
            {
                DataTable dt = GameRepository.GetAllGames(language, user, idArticle, id, title, subtitle, idPlatform, orderBy);
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

        public static List<UserFavGameModel> CheckIfFav(string user = "", int idGame = -1)
        {
            try
            {
                DataTable dt = GameRepository.CheckIfFav(user, idGame);
                List<UserFavGameModel> list = new List<UserFavGameModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UserFavGameModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UserFavGameModel> list = new List<UserFavGameModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<GameModel> GetGameScore(string language = "", string user = "", int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "")
        {
            try
            {
                DataTable dt = GameRepository.GetGameScore( language, user, id, title, subtitle, idPlatform, orderBy  );
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

            GameRepository.CreateGame( title, subtitle, description, language, cover, releaseDate, totalScore, isFav2, idDev, idPlatform, idPublisher, idGenre, idPlayerType, idLanguageGame );
        }

        public static void UpdateGame(int id = -1, string title = "", string subtitle = "", string description = "", string language = "", string cover = "", string releaseDate = "", sbyte totalScore = 0, bool isFav = false, int idDev = -1, int idPlatform = -1, int idPublisher = -1, List<int> idGenre = null, List<int> idPlayerType = null, List<int> idLanguageGame = null)
        {
            sbyte isFav2 = Utility.BoolToSByte(isFav);

            GameRepository.UpdateGame( id, title, subtitle, description, language, cover, releaseDate, totalScore, isFav2, idDev, idPlatform, idPublisher, idGenre, idPlayerType, idLanguageGame );
        }

        public static void DeleteGame(int id = -1)
        {
            GameRepository.DeleteGame( id );
        }
    }
}
