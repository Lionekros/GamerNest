using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class GameModel
    {
        public long id { get; set; }
        public string title { get; set; }
        public string subtitle { get; set; }
        public string description { get; set; }
        public string cover { get; set; }
        public string language { get; set; }
        public DateTime releaseDate { get; set; }
        public sbyte totalScore { get; set; }
        public sbyte isApproved { get; set; }
        public sbyte isFav { get; set; }
        public int idDev { get; set; }
        public int idPlatform { get; set; }
        public int idPublisher { get; set; }

        public GameModel(DataRow row)
        {
            id = row.Field<long>( "id" );
            title = row.Field<string>( "title" );
            subtitle = row.Field<string>( "subtitle" );
            description = row.Field<string>( "description" );
            cover = row.Field<string>( "cover" );
            language = row.Field<string>( "language" );
            releaseDate = row.Field<DateTime>( "releaseDate" );
            totalScore = row.Field<sbyte>( "totalScore" );
            isApproved = row.Field<sbyte>( "isApproved" );
            isFav = row.Field<sbyte>( "isFav" );
            idDev = row.Field<int>( "idDev" );
            idPlatform = row.Field<int>( "idPlatform" );
            idPublisher = row.Field<int>( "idPublisher" );
        }
    }
}
