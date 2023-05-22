using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UpdateArticleModel
    {
        public int id { get; set; }
        public string headline { get; set; }
        public string summary { get; set; }
        public string body { get; set; }
        public string cover { get; set; }
        public bool isPublished { get; set; }
        public string createdDate { get; set; }
        public string? updatedDate { get; set; }
        public int idAuthor { get; set; }
        public string language { get; set; }

        public string? author { get; set; }

        public List<GameModel>? gameList { get; set; }
        public List<int>? idGameList { get; set; }

        public UpdateArticleModel()
        {
        }

        public UpdateArticleModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            headline = row.Field<string>( "headline" );
            summary = row.Field<string>( "summary" );
            body = row.Field<string>( "body" );
            cover = row.Field<string>( "cover" );
            isPublished = Utility.sByteToBool( row.Field<sbyte>( "isPublished" ) );
            createdDate = row.Field<string>( "createdDate" );
            updatedDate = row.Field<string?>( "updatedDate" );
            idAuthor = row.Field<int>( "idAuthor" );
            language = row.Field<string>( "language" );
            author = row.Field<string>( "author" );
        }
    }
}
