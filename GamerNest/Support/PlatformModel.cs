using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class PlatformModel
    {
        public UInt64 id { get; set; }
        public string platform { get; set; }

        public PlatformModel(DataRow row) 
        { 
            id = row.Field<UInt64>("id");
            platform = row.Field<string>( "platform" );
        }
    }
}
