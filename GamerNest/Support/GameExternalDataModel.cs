using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class GameExternalDataModel
    {
        public int id { get; set; }
        public string name { get; set; }

        public GameExternalDataModel(DataRow row)
        {
            string field = "id";

            int selector = row.Field<int>("selector");
            switch ( selector )
            {
                case 1:
                    field = "idDev";
                    break;
                case 2:
                    field = "idGenre";
                    break;
                case 3:
                    field = "idLanguage";
                    break;
                case 4:
                    field = "idPlatform";
                    break;
                case 5:
                    field = "idPlayerType";
                    break;
                case 6:
                    field = "idPublisher";
                    break;
            }

            id = row.Field<int>( field );
            name = row.Field<string>( field );
        }
    }
}
