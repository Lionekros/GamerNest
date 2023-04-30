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
                
            )
        {
            try
            {
                DataTable dt = AuthorRepository.GetAllAuthors(id, name, firstLastName, secondLastName, email, isAdmin, isActive, orderBy);
                List<AuthorModel> list = new List<AuthorModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new AuthorModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<AuthorModel> list = new List<AuthorModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<AuthorModel> GetAuthor(string emailOrPhone)
        {
            try
            {
                DataTable dt = AuthorRepository.GetAuthor(emailOrPhone);
                List<AuthorModel> list = new List<AuthorModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new AuthorModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<AuthorModel> list = new List<AuthorModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static List<UpdateAuthorModel> GetAuthorUpdate(string emailOrPhone)
        {
            try
            {
                DataTable dt = AuthorRepository.GetAuthor(emailOrPhone);
                List<UpdateAuthorModel> list = new List<UpdateAuthorModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new UpdateAuthorModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<UpdateAuthorModel> list = new List<UpdateAuthorModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }

        public static void CreateAuthor
            (
                  string    name                = ""
                , string    firstLastName       = ""
                , string    secondLastName      = ""
                , string    password            = ""
                , string    email               = ""
                , string    phone               = ""
                , string    description         = ""
                , string    avatar              = ""
                , string    preferedLanguage    = ""
                , bool      isAdmin             = false
                , bool      canPublish          = false
                , bool      isActive            = true
                , string    birthday            = ""
                , string    startDate           = ""
                , string    endDate             = ""
            )
        {
            sbyte isAdmin2 = Utility.BoolToSByte( isAdmin );
            sbyte canPublish2 = Utility.BoolToSByte( canPublish );
            sbyte isActive2 = Utility.BoolToSByte( isActive );

            password = Utility.EncriptPassword( password );
            
            AuthorRepository.CreateAuthor(name, firstLastName, secondLastName, password, email, phone, description, avatar, preferedLanguage, isAdmin2, canPublish2, isActive2, birthday, startDate, endDate);
        }

        public static void UpdateAuthor
            (
                  int       id                  = -1
                , string    name                = ""
                , string    firstLastName       = ""
                , string    secondLastName      = ""
                , string    password            = ""
                , bool      changedPassword     = false
                , string    email               = ""
                , string    phone               = ""
                , string    description         = ""
                , string    avatar              = ""
                , string    preferedLanguage    = ""
                , bool      isAdmin             = false
                , bool      canPublish          = false
                , bool      isActive            = true
                , string    birthday            = ""
                , string    startDate           = ""
                , string    endDate             = ""
            )
        {
            sbyte isAdmin2 = Utility.BoolToSByte( isAdmin );
            sbyte canPublish2 = Utility.BoolToSByte( canPublish );
            sbyte isActive2 = Utility.BoolToSByte( isActive );

            if (changedPassword)
            {
                password = Utility.EncriptPassword( password );
            }
            
            AuthorRepository.UpdateAuthor( id, name, firstLastName, secondLastName, password, email, phone, description, avatar, preferedLanguage, isAdmin2, canPublish2, isActive2, birthday, startDate, endDate );
        }

        public static void DeleteAuthor( int id = -1)
        {
            AuthorRepository.DeleteAuthor( id );
        }
    }
}
