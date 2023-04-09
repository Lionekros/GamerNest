using DBAccess;
using LogError;
using Mysqlx.Crud;
using Support;
using System.Data;

namespace Domain
{
    public class GenreService
    {
        public static List<GameExternalDataModel> GetAllGenres(string language = "ENG", string orderBy = "", int limit = -1)
        {
            try
            {
                DataTable dt = GenreRepository.GetAllGenres(language, orderBy, limit);

                List<GameExternalDataModel> genreList = new List<GameExternalDataModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    genreList.Add( new GameExternalDataModel( row ) );
                }

                return genreList;
            }
            catch ( Exception ex )
            {
                List<GameExternalDataModel> genreList = new List<GameExternalDataModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return genreList;

            }
        }
    }
}
