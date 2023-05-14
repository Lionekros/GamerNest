using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class GameScoreModel
    {
        public long id { get; set; }
        
        public string title { get; set; }
        public string? subtitle { get; set; }
        
        public string cover { get; set; }
        
        public sbyte? totalScore { get; set; }
        
        public int idPlatform { get; set; }
        public string? platform { get; set; }
        public string? platformIcon { get; set; }

        public sbyte? userScore { get; set; }
        public string? user { get; set; }

        public GameScoreModel()
        {
        }

        public GameScoreModel(DataRow row)
        {
            id = row.Field<long>( "id" );
            title = row.Field<string>( "title" );
            subtitle = row.Field<string>( "subtitle" );
            cover = row.Field<string>( "cover" );
            totalScore = row.Field<sbyte>( "totalScore" );
            idPlatform = row.Field<int>( "idPlatform" );
            platform = row.Field<string?>( "platform" );
            platformIcon = row.Field<string?>( "platformIcon" );

            userScore = row.Field<sbyte?>( "score" );
            user = row.Field<string?>( "username" );
        }
    }
}
