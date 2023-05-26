using LogError;

namespace Support
{
    public static class Utility
    {
        public static bool sByteToBool(sbyte num)
        {
            return num == 1 ? true : false;
        }

        public static sbyte BoolToSByte(bool op)
        {
            return op ? (sbyte) 1 : (sbyte) 0;
        }

        public static bool longToBool(long num)
        {
            return num == 1 ? true : false;
        }

        public static long BoolToLong(bool op)
        {
            return op ? 1 : 0;
        }

        public static string EncriptPassword(this string password)
        {
            try
            {
                return BCrypt.Net.BCrypt.HashPassword( password );
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

        public static string DateTimeToString(DateTime dateTime)
        {
            return dateTime.ToString( "dd/MM/yyyy" );
        }

        public static DateTime StringToDateTime(string dateString)
        {
            return DateTime.ParseExact( dateString, "dd/MM/yyyy", null );
        }
    }
}
