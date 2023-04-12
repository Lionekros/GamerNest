using DBAccess;
using LogError;
using Support;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class AuthorService
    {
        public static List<AuthorModel> GetAllAuthors
            (
                  int       id              = -1
                , string    name            = ""
                , string    firstLastName   = ""
                , string    secondLastName  = ""
                , string    email           = ""
                , sbyte     isAdmin         = -1
                , sbyte     isActive        = -1
                , string    orderBy         = ""
                , int       limit           = -1
            )
        {
            try
            {
                DataTable dt = AuthorRepository.GetAllAuthors(id, name, firstLastName, secondLastName, email, isAdmin, isActive, orderBy, limit);
                List<AuthorModel> authorList = new List<AuthorModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    authorList.Add( new AuthorModel( row ) );
                }

                return authorList;
            }
            catch ( Exception ex )
            {
                List<AuthorModel> authorList = new List<AuthorModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return authorList;

            }
        }

        public static List<AuthorModel> GetAuthor(string email)
        {
            try
            {
                DataTable dt = AuthorRepository.GetAuthor(email);
                List<AuthorModel> authorList = new List<AuthorModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    authorList.Add( new AuthorModel( row ) );
                }

                return authorList;
            }
            catch ( Exception ex )
            {
                List<AuthorModel> authorList = new List<AuthorModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return authorList;

            }
        }
    }
}
