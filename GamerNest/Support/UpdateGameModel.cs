using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UpdateGameModel
    {
        public long id { get; set; }
        public string title { get; set; }
        public string? subtitle { get; set; }
        public string description { get; set; }
        public string? cover { get; set; }
        public string language { get; set; }
        public string? releaseDate { get; set; }
        public sbyte totalScore { get; set; }
        public bool isFav { get; set; }
        public int idDev { get; set; }
        public string? dev { get; set; }
        public int idPlatform { get; set; }
        public string? platform { get; set; }
        public string? platformIcon { get; set; }
        public int idPublisher { get; set; }
        public string? publisher { get; set; }

        public List<int> idGenre { get; set; }
        public List<int> idPlayerType { get; set; }
        public List<int> idLanguageGame { get; set; }

        public List<GenreTypeLanguageModel>? genreList { get; set; }
        public List<GenreTypeLanguageModel>? playerTypeList { get; set; }
        public List<GenreTypeLanguageModel>? languageGameList { get; set; }

        public List<DevPublisherModel>? devList { get; set; }
        public List<DevPublisherModel>? publisherList { get; set; }
        public List<PlatformModel>? platformList { get; set; }

        public UpdateGameModel()
        {
        }

        public UpdateGameModel(DataRow row)
        {
            id = row.Field<long>( "id" );
            title = row.Field<string>( "title" );
            subtitle = row.Field<string>( "subtitle" );
            description = row.Field<string>( "description" );
            cover = row.Field<string?>( "cover" );
            language = row.Field<string>( "language" );
            releaseDate = row.Field<string>( "releaseDate" );
            totalScore = row.Field<sbyte>( "totalScore" );
            isFav = Utility.sByteToBool(row.Field<sbyte>( "isFav" ));
            idDev = row.Field<int>( "idDev" );
            dev = row.Field<string?>( "dev" );
            idPlatform = row.Field<int>( "idPlatform" );
            platform = row.Field<string?>( "platform" );
            platformIcon = row.Field<string?>( "platformIcon" );
            idPublisher = row.Field<int>( "idPublisher" );
            publisher = row.Field<string?>( "publisher" );
        }
    }
}
