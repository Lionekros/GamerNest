using LogError;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public static class Utility
    {
        public static bool ConvertToBool(sbyte num)
        {
            return num == 1 ? true : false;
        }

        public static sbyte ConvertToTinyInt(bool op) 
        {
            return op ? (sbyte) 1 : (sbyte) 0;
        }

        public static string EncriptPassword(this string password)
        {
            try
            {
                return BCrypt.Net.BCrypt.HashPassword(password);
            }
            catch ( Exception ex )
            {
                List<AuthorModel> authorList = new List<AuthorModel>();
                Log log = new Log();
                return "1234567890123456789012345678901";

            }
        }

        public static bool VerifyPassword(string formPassword, string dbPassword)
        {
            try
            {
                return BCrypt.Net.BCrypt.Verify( formPassword, dbPassword );
            }
            catch ( Exception ex )
            {
                List<AuthorModel> authorList = new List<AuthorModel>();
                Log log = new Log();
                return false;

            }
        }
    }
}
