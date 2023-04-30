using Domain;
using Microsoft.AspNetCore.Mvc;
using Support;

namespace View.Controllers
{
    public class GetBaseController :Controller
    {
        public ModelList lists = new ModelList();

        // AUTHOR METHODS

        // Retrieves a list of authors based on specified parameters
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

        // Retrieves a single author based on their email address
        public void GetAuthor(string email)
        {
            lists.authorList = AuthorService.GetAuthor( email );
        }

        // Retrieves a single author based on their email address and returns additional update data
        public void GetAuthorUpdate(string email)
        {
            lists.updateAuthorList = AuthorService.GetAuthorUpdate( email );
        }


        // CATEGORY METHODS

        // Retrieves a list of categories based on specified parameters
        public void GetAllCategories(
            int id = -1,
            string name = "",
            string orderBy = ""
            
        )
        {
            lists.categoryList = CategoryService.GetAllCategories( id, name, orderBy );
        }

        // Retrieves a single category based on its ID
        public void GetCategory(int id)
        {
            lists.categoryList = CategoryService.GetCategory( id );
        }

        // Retrieves a single category based on its ID and returns additional update data
        public void GetCategoryUpdate(int id)
        {
            lists.updateCategoryList = CategoryService.GetCategoryUpdate( id );
        }


        // WEB LANGUAGE METHODS

        // Retrieves a list of web languages based on specified parameters
        public void GetAllWebLanguages(
            string id = "",
            string name = "",
            string orderBy = ""
            
        )
        {
            lists.webLanguageList = WebLanguageService.GetAllWebLanguages( id, name, orderBy );
        }

        // Retrieves a single web language based on its ID
        public void GetWebLanguage(string email)
        {
            lists.webLanguageList = WebLanguageService.GetWebLanguage( email );
        }

        // Retrieves a single web language based on its ID and returns additional update data
        public void GetWebLanguageUpdate(string email)
        {
            lists.updateWebLanguageList = WebLanguageService.GetWebLanguageUpdate( email );
        }

        // WEB TEXT METHODS

        // Retrieves a list of web texts based on specified parameters
        public void GetAllTexts(
            int id = -1, string title = "", int idCategory = -1, string language = "", string orderBy = ""

        )
        {
            lists.webTextList = WebTextService.GetAllTexts( id, title, idCategory, language, orderBy );
        }

        // Retrieves a list of web texts for a specific category and language
        public void GetAllTextsByCategory(string cat, string lang = "ENG")
        {
            lists.textList = WebTextService.GetAllTextsByCategory( cat, lang );
        }

        // Retrieves a single web text based on its ID
        public void GetText(int id)
        {
            lists.webTextList = WebTextService.GetText( id );
        }

        // Retrieves a single web text based on its ID and returns additional update data
        public void GetTextUpdate(int id)
        {
            lists.updateWebTextList = WebTextService.GetTextUpdate( id );
        }
    }

}
