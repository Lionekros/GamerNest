using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class UpdateDevPublisherModel
    {
        [Required( ErrorMessage = "Required" )]
        public int id { get; set; }
        public string name { get; set; }

        public UpdateDevPublisherModel() { }

        public UpdateDevPublisherModel(DataRow row)
        {
            string field = "id";

            long selector = row.Field<long>("selector");
            switch ( selector )
            {
                case 0:
                    field = "idDev";
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
