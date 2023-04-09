using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class ArticleModel
    {
        public long id { get; set; }
        public string headline { get; set; }
        public string summary { get; set; }
        public string body { get; set; }
        public string cover { get; set; }
        public sbyte isPublished { get; set; }
        public DateTime createdDate { get; set; }
        public DateTime? updatedDate { get; set; }
        public int idAuthor { get; set; }
        public string language { get; set; }

        public ArticleModel(DataRow row)
        {
            id = row.Field<long>( "id" );
            headline = row.Field<string>( "headline" );
            summary = row.Field<string>( "summary" );
            body = row.Field<string>( "body" );
            cover = row.Field<string>( "cover" );
            isPublished = row.Field<sbyte>( "isPublished" );
            createdDate = row.Field<DateTime>( "createdDate" );
            updatedDate = row.Field<DateTime?>( "updatedDate" );
            idAuthor = row.Field<int>( "idAuthor" );
            language = row.Field<string>( "language" );
        }
    }
}
