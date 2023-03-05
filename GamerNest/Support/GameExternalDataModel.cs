using System.Data;

namespace Support
{
    public class GameExternalDataModel
    {
        public int id { get; set; }
        public string name { get; set; }

        public GameExternalDataModel(DataRow row)
        {
            string field = "id";

            long selector = row.Field<long>("selector");
            switch ( selector )
            {
                case 0:
                    field = "idDev";
                    break;
                case 1:
                    field = "idGenre";
                    break;
                case 2:
                    field = "idLanguage";
                    break;
                case 3:
                    field = "idPlatform";
                    break;
                case 4:
                    field = "idPlayerType";
                    break;
                case 5:
                    field = "idPublisher";
                    break;
            }

            id = row.Field<int>( field );
            name = row.Field<string>( "name" );
        }
    }
}
