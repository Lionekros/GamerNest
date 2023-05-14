namespace Support
{
    public class ModelList
    {
        //Pagination
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
        public int TotalItems { get; set; }

        public List<ArticleModel> articleList { get; set; }
        public List<AuthorModel> authorList { get; set; }
        public List<CategoryModel> categoryList { get; set; }
        public List<DevPublisherModel> devList { get; set; }
        public List<DevPublisherModel> publisherList { get; set; }
        public List<GameModel> gameList { get; set; }
        public List<GameScoreModel> gameScoreList { get; set; }
        public List<GenreTypeLanguageModel> genreList { get; set; }
        public List<GenreTypeLanguageModel> languageList { get; set; }
        public List<GenreTypeLanguageModel> playerTypeList { get; set; }
        public List<PlatformModel> platformList { get; set; }
        public List<UserModel> userList { get; set; }
        public List<WebLanguageModel> webLanguageList { get; set; }
        public List<WebTextModel> webTextList { get; set; }
        public List<WebTextModel> textList { get; set; }


        public List<UpdateArticleModel> updateArticleList { get; set; }
        public List<UpdateAuthorModel> updateAuthorList { get; set; }
        public List<UpdateCategoryModel> updateCategoryList { get; set; }
        public List<UpdateDevPublisherModel> updateDevList { get; set; }
        public List<UpdateDevPublisherModel> updatePublisherList { get; set; }
        public List<UpdateGameModel> updateGameList { get; set; }
        public List<UpdateGenreTypeLanguageModel> updateGenreList { get; set; }
        public List<UpdateGenreTypeLanguageModel> updateLanguageList { get; set; }
        public List<UpdateGenreTypeLanguageModel> updatePlayerTypeList { get; set; }
        public List<UpdatePlatformModel> updatePlatformList { get; set; }
        public List<UpdateUserModel> updateUserList { get; set; }
        public List<UpdateWebLanguageModel> updateWebLanguageList { get; set; }
        public List<UpdateWebTextModel> updateWebTextList { get; set; }

    }
}
