using System;
using System.Diagnostics;
using System.IO;

namespace LogError
{
    public class Log
    {
        private string adminPath = Directory.GetCurrentDirectory() + @"\Log\";
        private string userPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments) + @"\GamerNestLog\";


        public void Add(string errorMessage)
        {
            AdminLog(errorMessage);
            UserLog( errorMessage );
        }

        #region Utilities
        private string CreateFilename()
        {
            string name = string.Empty;

            name = "log_" + DateTime.Now.Day + "_" + DateTime.Now.Month + "_" + DateTime.Now.Year + ".txt";

            return name;
        }

        private void CreateDirectory(string path)
        {
            try
            {
                if ( !Directory.Exists( path ) )
                {
                    Directory.CreateDirectory( path );
                }
            }
            catch ( DirectoryNotFoundException ex )
            {
                throw new Exception( ex.Message );
            }

        }

        private void AdminLog(string errorMessage)
        {
            CreateDirectory(adminPath);
            string name = CreateFilename();
            string chain = "";

            // Get the stack trace
            StackTrace stackTrace = new StackTrace(true);
            StackFrame frame = stackTrace.GetFrame(1); // Get the second frame, which is the caller of this method
            string fileName = frame.GetFileName();
            int lineNumber = frame.GetFileLineNumber();

            // Include file name and line number in the log message
            chain += DateTime.Now + " - Error in file: " + fileName + ", Line: " + lineNumber + ", Error Message: " + errorMessage + Environment.NewLine;

            StreamWriter sw = new StreamWriter(Path.Combine(adminPath, name), true);
            sw.Write( chain );
            sw.Close();
        }
        private void UserLog(string errorMessage)
        {
            CreateDirectory(userPath);
            string name = CreateFilename();
            string chain = "";

            chain += DateTime.Now + " - " + errorMessage + Environment.NewLine;

            StreamWriter sw = new StreamWriter(userPath + "/" + name, true);
            sw.Write( chain );
            sw.Close();
        }
        #endregion
    }
}
