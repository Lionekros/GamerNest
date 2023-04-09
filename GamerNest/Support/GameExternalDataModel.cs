using System.Data;

namespace Support
{
    public class GameExternalDataModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public string icon { get; set; }
        public string language { get; set; }

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

            if (selector == 3)
            {
                icon = row.Field<string>( "icon" );
            }

            if ( selector == 1 || selector == 2  || selector == 4 )
            {
                language = row.Field<string>( "language" );
            }
        }
    }
}
