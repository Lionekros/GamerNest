using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace LogError
{
    public class Log
    {
        private string path = Directory.GetCurrentDirectory() + @"\Log\";

        public void Add(string errorMessage)
        {
            CreateDirectory();
            string name = CreateFilename();
            string chain = "";

            chain += DateTime.Now + " - " + errorMessage + Environment.NewLine;

            StreamWriter sw = new StreamWriter(path+"/"+name, true);
            sw.Write(chain);
            sw.Close();
        }

        #region Utilities
        private string CreateFilename()
        {
            string name = string.Empty;

            name = "log_" + DateTime.Now.Day + "_" + DateTime.Now.Month + "_" + DateTime.Now.Year + ".txt";

            return name;
        }

        private void CreateDirectory()
        {
            try
            {
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
            }
            catch (DirectoryNotFoundException ex)
            {
                throw new Exception(ex.Message);
            }
            
        }
        #endregion
    }
}
