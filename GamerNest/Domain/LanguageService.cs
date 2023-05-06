using DBAccess;
using LogError;
using Mysqlx.Crud;
using Support;
using System.Data;

namespace Domain
{
    public class LanguageService
    {
        public static List<GenreTypeLanguageModel> GetAllLanguages(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
        {
            try
            {
                DataTable dt = LanguageRepository.GetAllLanguages(language, idGame, id, name, orderBy);
                List<GenreTypeLanguageModel> LanguageList = new List<GenreTypeLanguageModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    LanguageList.Add( new GenreTypeLanguageModel( row ) );
                }

                return LanguageList;
            }
            catch ( Exception ex )
            {
                List<GenreTypeLanguageModel> LanguageList = new List<GenreTypeLanguageModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return LanguageList;

            }
        }

        public static List<GenreTypeLanguageModel> GetLanguage(int id)
        {
            try
            {
                DataTable dt = LanguageRepository.GetLanguage(id);
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

        public static List<UpdateGenreTypeLanguageModel> GetLanguageUpdate(int id)
        {
            try
            {
                DataTable dt = LanguageRepository.GetLanguage(id);
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

        public static void CreateLanguage(string name = "", string language = "")
        {

            LanguageRepository.CreateLanguage( name, language );
        }

        public static void UpdateLanguage(int id = -1, string name = "", string language = "")
        {
            LanguageRepository.UpdateLanguage( id, name, language );
        }

        public static void DeleteLanguage(int id = -1)
        {
            LanguageRepository.DeleteLanguage( id );
        }
    }
}
