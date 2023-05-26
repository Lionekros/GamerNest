using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class PlayerTypeService
    {
        public static List<GenreTypeLanguageModel> GetAllPlayerTypes(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                DataTable dt = PlayerTypeRepository.GetAllPlayerTypes(language, idGame, id, name, orderBy);
                List<GenreTypeLanguageModel> PlayerTypeList = new List<GenreTypeLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    PlayerTypeList.Add( new GenreTypeLanguageModel( row ) );
                }

                return PlayerTypeList;
            }
            catch ( Exception ex )
            {
                List<GenreTypeLanguageModel> PlayerTypeList = new List<GenreTypeLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return PlayerTypeList;

            }
        }

        public static List<GenreTypeLanguageModel> GetPlayerType(int id)
        {
            try
            {
                DataTable dt = PlayerTypeRepository.GetPlayerType(id);
                List<GenreTypeLanguageModel> list = new List<GenreTypeLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new GenreTypeLanguageModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<GenreTypeLanguageModel> list = new List<GenreTypeLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdateGenreTypeLanguageModel> GetPlayerTypeUpdate(int id)
        {
            try
            {
                DataTable dt = PlayerTypeRepository.GetPlayerType(id);
                List<UpdateGenreTypeLanguageModel> list = new List<UpdateGenreTypeLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateGenreTypeLanguageModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateGenreTypeLanguageModel> list = new List<UpdateGenreTypeLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreatePlayerType(string name = "", string language = "")
        {

            PlayerTypeRepository.CreatePlayerType( name, language );
        }

        public static void UpdatePlayerType(int id = -1, string name = "", string language = "")
        {
            PlayerTypeRepository.UpdatePlayerType( id, name, language );
        }

        public static void DeletePlayerType(int id = -1)
        {
            PlayerTypeRepository.DeletePlayerType( id );
        }
    }
}
