﻿using Domain;
using LogError;
using Microsoft.AspNetCore.Mvc;

namespace View.Controllers
{
    public class GameController :MethodBaseController
    {
        public ActionResult AllGames
            (
                  int page = 1
                , int pageSize = 10,
                string language = "", bool isFav = false, int idArticle = -1, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "title"
            )
        {
            try
            {
                UserDefault();
                string user = HttpContext.Session.GetString( "UserUsername" );
                language = HttpContext.Session.GetString( "PageLanguage" );
                if ( isFav )
                {
                    GetAllGames( language, user, idArticle, id, title, subtitle, idPlatform, orderBy );
                }
                else
                {
                    GetAllGames( language, "", idArticle, id, title, subtitle, idPlatform, orderBy );
                }


                FiltersViewBag( language, user, idArticle, id, title, subtitle, idPlatform, orderBy );


                GetAllPlatforms( -1, "", "", "name" );

                if ( !string.IsNullOrEmpty( HttpContext.Session.GetString( "UserUsername" ) ) )
                {
                    foreach ( var item in lists.gameList )
                    {
                        item.isFav = IsFav( user, item.id );
                    }
                }

                Pagination( page, pageSize );

                WebText( "NormalGame" );
                return View( "AllGames", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "NormalGame" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult FavGames
            (
                  int page = 1
                , int pageSize = 10,
                string language = "", bool isFav = false, int idArticle = -1, bool scored = false, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = "title"
            )
        {
            try
            {
                UserDefault();
                string user = HttpContext.Session.GetString( "UserUsername" );
                language = HttpContext.Session.GetString( "PageLanguage" );

                GetAllGames( language, user, idArticle, id, title, subtitle, idPlatform, orderBy );


                FiltersViewBag( language, user, idArticle, id, title, subtitle, idPlatform, orderBy );


                GetAllPlatforms( -1, "", "", "name" );

                foreach ( var item in lists.gameList )
                {
                    item.isFav = IsFav( user, item.id );
                }

                Pagination( page, pageSize );

                WebText( "NormalGame" );
                return View( "FavGames", lists );
            }
            catch ( Exception ex )
            {

                Log log = new Log();
                log.Add( ex.Message );
                WebText( "NormalGame" );
                ViewBag.ErrorTryCatch = ViewData[ "ErrorOccurred" ];
                return RedirectToAction( "Index", "Admin" );
            }
        }

        public ActionResult SeeGame(int id)
        {
            UserDefault();
            string user = HttpContext.Session.GetString( "UserUsername" );
            GetAllGames( "", "", -1, id );
            if ( !string.IsNullOrEmpty( HttpContext.Session.GetString( "UserUsername" ) ) )
            {
                foreach ( var item in lists.gameList )
                {
                    item.isFav = IsFav( user, item.id );
                }
            }

            GetAllGenres( "", id );
            GetAllPlayerTypes( "", id );
            GetAllLanguages( "", id );

            WebText( "NormalGame" );
            return View( "SeeGames", lists );
        }

        public bool IsFav(string user, int idGame)
        {
            CheckIfFav( user, idGame );
            if ( lists.favList.Count > 0 )
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public ActionResult GameIsFav(int idGame, bool isSingleGame = false, bool isFav = false)
        {
            GameService.CreateFav( int.Parse( HttpContext.Session.GetString( "UserID" ) ), idGame );

            if ( isSingleGame )
            {
                return RedirectToAction( "SeeGame", new { id = idGame } );
            }
            else if ( isFav )
            {
                return RedirectToAction( "FavGames" );
            }
            else
            {
                return RedirectToAction( "AllGames" );
            }

        }

        public ActionResult GameIsNotFav(int idGame, bool isSingleGame = false, bool isFav = false)
        {
            GameService.DeleteFav( int.Parse( HttpContext.Session.GetString( "UserID" ) ), idGame );

            if ( isSingleGame )
            {
                return RedirectToAction( "SeeGame", new { id = idGame } );
            }
            else if ( isFav )
            {
                return RedirectToAction( "FavGames" );
            }
            else
            {
                return RedirectToAction( "AllGames" );
            }
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

        public void FiltersViewBag
            (
                  string language = "", string user = "", int idArticle = -1, int id = -1, string title = "", string subtitle = "", int idPlatform = -1, string orderBy = ""
            )
        {
            ViewBag.FormData = new
            {
                language = language,
                user = user,
                idArticle = idArticle,
                id = id,
                title = title,
                subtitle = subtitle,
                idPlatform = idPlatform,
                orderBy = orderBy
            };
        }

    }
}
