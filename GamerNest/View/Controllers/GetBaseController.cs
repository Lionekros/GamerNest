using Domain;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class GetBaseController :Controller
    {
        public ModelList lists = new ModelList();

        #region Article
        public void GetAllArticles(string language = "", string author = "", int idGame = -1, int id = -1, string headline = "", sbyte isPublished = -1, string orderBy = "", bool isFav = false, int user = -1)
        {
            lists.articleList = ArticleService.GetAllArticles( language, author, idGame, id, headline, isPublished, orderBy, isFav, user );
        }

        public void GetArticle(int id = -1)
        {
            lists.articleList = ArticleService.GetArticle( id );
        }

        public void GetArticleUpdate(int id = -1)
        {
            lists.updateArticleList = ArticleService.GetArticleUpdate( id );
        }
        #endregion

        #region Author
        public void GetAllAuthors(
            int id = -1,
            string name = "",
            string firstLastName = "",
            string secondLastName = "",
            string email = "",
            sbyte isAdmin = -1,
            sbyte isActive = -1,
            string orderBy = ""
        )
        {
            lists.authorList = AuthorService.GetAllAuthors( id, name, firstLastName, secondLastName, email, isAdmin, isActive, orderBy );
        }

        public void GetAuthor(string email)
        {
            lists.authorList = AuthorService.GetAuthor( email );
        }

        public void GetAuthorUpdate(string email)
        {
            lists.updateAuthorList = AuthorService.GetAuthorUpdate( email );
        }
        #endregion

        #region Category
            public void GetAllCategories(int id = -1, string name = "", string orderBy = "")
            {
                lists.categoryList = CategoryService.GetAllCategories( id, name, orderBy );
            }

            public void GetCategory(int id)
            {
                lists.categoryList = CategoryService.GetCategory( id );
            }

            public void GetCategoryUpdate(int id)
            {
                lists.updateCategoryList = CategoryService.GetCategoryUpdate( id );
            }
        #endregion

        #region Dev
        public void GetAllDevs(int id = -1, string name = "", string orderBy = "")
            {
                lists.devList = DevService.GetAllDevs( id, name, orderBy );
            }

            public void GetDev(int id)
            {
                lists.devList = DevService.GetDev( id );
            }

            public void GetDevUpdate(int id)
            {
                lists.updateDevList = DevService.GetDevUpdate( id );
            }
        #endregion

        #region Game
        public void GetAllGames(string language = "", string user = "", int idArticle = -1, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "")
        {
            lists.gameList = GameService.GetAllGames( language, user, idArticle, id, title, subtitle, idPlatform, orderBy );
        }

        public void GetGame(int id = -1)
        {
            lists.gameList = GameService.GetGame( id );
        }

        public void GetGameScore(string language = "", string user = "", int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "")
        {
            lists.gameList = GameService.GetGameScore( language, user, id, title, subtitle, idPlatform, orderBy  );
        }

        public void GetGameUpdate(int id = -1)
        {
            lists.updateGameList = GameService.GetGameUpdate( id );
        }
        #endregion

        #region Genre
        public void GetAllGenres(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
            {
                lists.genreList = GenreService.GetAllGenres( language, idGame, id, name, orderBy );
            }

            public void GetGenre(int id)
            {
                lists.genreList = GenreService.GetGenre( id );
            }

            public void GetGenreUpdate(int id)
            {
                lists.updateGenreList = GenreService.GetGenreUpdate( id );
            }
        #endregion

        #region Language
        public void GetAllLanguages(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "")
            {
                lists.languageList = LanguageService.GetAllLanguages( language, idGame, id, name, orderBy );
            }

            public void GetLanguage(int id)
            {
                lists.languageList = LanguageService.GetLanguage( id );
            }

            public void GetLanguageUpdate(int id)
            {
                lists.updateLanguageList = LanguageService.GetLanguageUpdate( id );
            }
        #endregion

        #region Platform
        public void GetAllPlatforms(int id = -1, string name = "", string icon = "", string orderBy = "")
            {
                lists.platformList = PlatformService.GetAllPlatforms( id, name, icon, orderBy );
            }

            public void GetPlatform(int id)
            {
                lists.platformList = PlatformService.GetPlatform( id );
            }

            public void GetPlatformUpdate(int id)
            {
                lists.updatePlatformList = PlatformService.GetPlatformUpdate( id );
            }
        #endregion

        #region Player Type
        public void GetAllPlayerTypes(string language = "", int idGame = -1, int id = -1, string name = "", string orderBy = "" )
            {
                lists.playerTypeList = PlayerTypeService.GetAllPlayerTypes( language, idGame, id, name, orderBy );
            }

            public void GetPlayerType(int id)
            {
                lists.playerTypeList = PlayerTypeService.GetPlayerType( id );
            }

            public void GetPlayerTypeUpdate(int id)
            {
                lists.updatePlayerTypeList = PlayerTypeService.GetPlayerTypeUpdate( id );
            }
        #endregion

        #region Publisher
        public void GetAllPublishers(int id = -1, string name = "", string orderBy = "")
            {
                lists.publisherList = PublisherService.GetAllPublishers( id, name, orderBy );
            }

            public void GetPublisher(int id)
            {
                lists.publisherList = PublisherService.GetPublisher( id );
            }

            public void GetPublisherUpdate(int id)
            {
                lists.updatePublisherList = PublisherService.GetPublisherUpdate( id );
            }
        #endregion

        #region Web Text
        public void GetAllTexts(int id = -1, string title = "", int idCategory = -1, string language = "", string orderBy = "")
            {
                lists.webTextList = WebTextService.GetAllTexts( id, title, idCategory, language, orderBy );
            }

            public void GetAllTextsByCategory(string cat, string lang = "ENG")
            {
                lists.textList = WebTextService.GetAllTextsByCategory( cat, lang );
            }

            public void GetText(int id)
            {
                lists.webTextList = WebTextService.GetText( id );
            }

            public void GetTextUpdate(int id)
            {
                lists.updateWebTextList = WebTextService.GetTextUpdate( id );
            }
        #endregion

        #region User
        public void GetAllUsers(int id = -1, string username = "", string email = "", string orderBy = "")
        {
            lists.userList = UserService.GetAllUsers( id, username, email, orderBy );
        }

        public void GetUser(int id)
        {
            lists.userList = UserService.GetUser( id );
        }

        public void GetUserUpdate(int id)
        {
            lists.updateUserList = UserService.GetUserUpdate( id );
        }
        #endregion

        #region Web Language
        public void GetAllWebLanguages(string id = "", string name = "", string orderBy = "")
        {
            lists.webLanguageList = WebLanguageService.GetAllWebLanguages( id, name, orderBy );
        }

        public void GetWebLanguage(string email)
        {
            lists.webLanguageList = WebLanguageService.GetWebLanguage( email );
        }

        public void GetWebLanguageUpdate(string email)
        {
            lists.updateWebLanguageList = WebLanguageService.GetWebLanguageUpdate( email );
        }
        #endregion


    }

}
