namespace Support
{
    public class ModelList
    {
        //Pagination
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
        public int TotalItems { get; set; }

        public List<WebTextModel> textList { get; set; }


        public WebTextModel textModel { get; set; }
        public UpdateWebTextModel updateTextModel { get; set; }
        public List<WebTextModel> webTextList { get; set; }
        public List<UpdateWebTextModel> updateWebTextList { get; set; }

        public List<WebLanguageModel> webLanguageList { get; set; }
        public List<UpdateWebLanguageModel> updateWebLanguageList { get; set; }

        public List<CategoryModel> categoryList { get; set; }
        public List<UpdateCategoryModel> updateCategoryList { get; set; }

        public List<AuthorModel> authorList { get; set; }
        public List<UpdateAuthorModel> updateAuthorList { get; set; }

        public List<GameExternalDataModel> devList { get; set; }
        public List<GameExternalDataModel> genreList { get; set; }
        public List<GameExternalDataModel> languageList { get; set; }
        public List<GameExternalDataModel> platformList { get; set; }
        public List<GameExternalDataModel> playerTypeList { get; set; }
        public List<GameExternalDataModel> publisherList { get; set; }

    }
}
