using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class AdminGameController :MethodBaseController
    {
        public ActionResult Games
            (
                  int page = 1
                , int pageSize = 5,
                string language = "", string user = "", long idArticle = -1, bool scored = false, int id = -1, string title = "", string subtitle = "", string orderBy = ""
            )
        {
            try
            {
                SetDefaultAdminViewDatas();

                if ( HttpContext.Session.GetString( "AdminType" ) == null )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                else
                {
                    if (scored)
                    {
                        GetGameScore(language, user, id, title, subtitle, orderBy );
                    }
                    else
                    {
                        GetAllGames( language, user, idArticle, id, title, subtitle, orderBy );
                    }
                    FiltersViewBag( language, user, idArticle, scored, id, title, subtitle, orderBy );

                    ViewBag.score = scored;
                }

                Pagination( page, pageSize );

                WebText( "AdminGame" );
                return View( "Game", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "AdminGame" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult CreateForm()
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == null || HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }

                SetDefaultAdminViewDatas();
                WebText( "AdminGameForm" );
                GameModel model = new GameModel();
                model.genreList = GenreService.GetAllGenres();
                model.playerTypeList = PlayerTypeService.GetAllPlayerTypes();
                model.languageGameList = LanguageService.GetAllLanguages();

                model.devList = DevService.GetAllDevs();
                model.publisherList = PublisherService.GetAllPublishers();
                model.platformList = PlatformService.GetAllPlatforms();

                return View( "CreateGame", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult UpdateForm(int id)
        {
            try
            {
                if ( HttpContext.Session.GetString( "AdminType" ) == null || HttpContext.Session.GetString( "AdminType" ) == "Author" )
                {
                    return RedirectToAction( "LogInForm", "Admin" );
                }
                SetDefaultAdminViewDatas();
                GetGameUpdate( id );
                UpdateGameModel model = lists.updateGameList[0];
                model.genreList = GenreService.GetAllGenres();
                model.playerTypeList = PlayerTypeService.GetAllPlayerTypes();
                model.languageGameList = LanguageService.GetAllLanguages();

                model.devList = DevService.GetAllDevs();
                model.publisherList = PublisherService.GetAllPublishers();
                model.platformList = PlatformService.GetAllPlatforms();

                List<GenreTypeLanguageModel> tempGenreList = GenreService.GetAllGenres("", id);
                List<GenreTypeLanguageModel> tempPlayerTypeList = PlayerTypeService.GetAllPlayerTypes("", id);
                List<GenreTypeLanguageModel> tempLangList = LanguageService.GetAllLanguages("", id);

                model.idGenre = new List<int>();
                model.idPlayerType = new List<int>();
                model.idLanguageGame = new List<int>();

                foreach ( var item in tempGenreList )
                {
                    model.idGenre.Add( item.id );
                }

                foreach ( var item in tempPlayerTypeList )
                {
                    model.idPlayerType.Add( item.id );
                }

                foreach ( var item in tempLangList )
                {
                    model.idLanguageGame.Add( item.id );
                }
                WebText( "AdminGameForm" );
                return View( "UpdateGame", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }

        }

        public ActionResult Create(GameModel model, IFormFile cover)
        {
            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                ModelState.Remove( "cover" );

                if ( ModelState.IsValid )
                {
                    CreateGameProcedure( model );
                    GetAllGames( "", "", -1, -1, "", "", "id" );
                    int lastIndex = lists.gameList.Count - 1;
                    model.id = lists.gameList[ lastIndex ].id;
                    model.cover = UploadImage( cover, model.id, "Cover", "Game", "cover" );
                    GameService.UpdateGame( model.id, model.title, model.subtitle, model.description, model.language, model.cover, model.releaseDate, model.totalScore, model.isFav, model.idDev, model.idPlatform, model.idPublisher, model.idGenre, model.idPlayerType, model.idLanguageGame );
                    return RedirectToAction( "Games" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();

                ViewBag.ErrorMessages = errorMessageList;

                model.genreList = GenreService.GetAllGenres();
                model.playerTypeList = PlayerTypeService.GetAllPlayerTypes();
                model.languageGameList = LanguageService.GetAllLanguages();

                model.devList = DevService.GetAllDevs();
                model.publisherList = PublisherService.GetAllPublishers();
                model.platformList = PlatformService.GetAllPlatforms();

                WebText( "AdminGameForm" );
                return View( "CreateGame", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Update(UpdateGameModel model, IFormFile cover)
        {

            try
            {
                WebText( "Messages" );
                List<string> errorMessageList = new List<string>();

                ModelState.Remove( "cover" );

                if ( ModelState.IsValid )
                {
                    model.cover = UploadImage( cover, model.id, "Cover", "Game", "cover" );
                    UpdateGameProcedure( model );
                    return RedirectToAction( "Games" );
                }
                else
                {
                    errorMessageList.Add( ViewData[ "FillAllData" ].ToString() );
                }
                SetDefaultAdminViewDatas();
                ViewBag.ErrorMessages = errorMessageList;

                model.genreList = GenreService.GetAllGenres();
                model.playerTypeList = PlayerTypeService.GetAllPlayerTypes();
                model.languageGameList = LanguageService.GetAllLanguages();

                model.devList = DevService.GetAllDevs();
                model.publisherList = PublisherService.GetAllPublishers();
                model.platformList = PlatformService.GetAllPlatforms();

                WebText( "AdminGameForm" );
                return View( "UpdateGame", model );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "Messages" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult Delete(int id)
        {
            DeleteGameProcedure( id );
            return RedirectToAction( "Games" );
        }

        public void Pagination(int page, int pageSize)
        {
            if ( lists.gameList != null )
            {
                int totalGames = lists.gameList.Count;

                int skippedGames = (page - 1) * pageSize;

                lists.gameList = lists.gameList.Skip( skippedGames ).Take( pageSize ).ToList();

                lists.PageSize = pageSize;
                lists.CurrentPage = page;
                lists.TotalItems = totalGames;
            }
        }

        public void CreateGameProcedure(GameModel model)
        {
            GameService.CreateGame( model.title, model.subtitle, model.description, model.language, model.cover, model.releaseDate, model.totalScore, model.isFav, model.idDev, model.idPlatform, model.idPublisher, model.idGenre, model.idPlayerType, model.idLanguageGame );
        }

        public void UpdateGameProcedure(UpdateGameModel model)
        {

            GameService.UpdateGame( model.id, model.title, model.subtitle, model.description, model.language, model.cover, model.releaseDate, model.totalScore, model.isFav, model.idDev, model.idPlatform, model.idPublisher, model.idGenre, model.idPlayerType, model.idLanguageGame );
        }

        public void DeleteGameProcedure(int id)
        {
            GameService.DeleteGame( id );
        }

        public void FiltersViewBag
            (
                  string language = "", string user = "", long idArticle = -1, bool scored = false, int id = -1, string title = "", string subtitle = "", string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                language = language,
                user = user,
                idArticle = idArticle,
                scored = scored,
                id = id,
                title = title,
                subtitle = subtitle,
                orderBy = orderBy
            };
        }
    }
}
