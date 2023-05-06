using DBAccess;
using LogError;
using Support;
using System.Data;

namespace Domain
{
    public class GenreService
    {
        public static List<GenreTypeLanguageModel> GetAllGenres(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                DataTable dt = GenreRepository.GetAllGenres(language, idGame, id, name, orderBy);
                List<GenreTypeLanguageModel> GenreList = new List<GenreTypeLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    GenreList.Add( new GenreTypeLanguageModel( row ) );
                }

                return GenreList;
            }
            catch ( Exception ex )
            {
                List<GenreTypeLanguageModel> GenreList = new List<GenreTypeLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return GenreList;

            }
        }

        public static List<GenreTypeLanguageModel> GetGenre(int id)
        {
            try
            {
                DataTable dt = GenreRepository.GetGenre(id);
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

        public static List<UpdateGenreTypeLanguageModel> GetGenreUpdate(int id)
        {
            try
            {
                DataTable dt = GenreRepository.GetGenre(id);
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

        public static void CreateGenre(string name = "", string language = "")
        {

            GenreRepository.CreateGenre( name, language );
        }

        public static void UpdateGenre(int id = -1, string name = "", string language = "")
        {
            GenreRepository.UpdateGenre( id, name, language );
        }

        public static void DeleteGenre(int id = -1)
        {
            GenreRepository.DeleteGenre( id );
        }
    }
}
