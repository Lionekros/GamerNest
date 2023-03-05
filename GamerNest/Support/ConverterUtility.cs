using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class ConverterUtility
    {
        public bool ConvertToBool(sbyte num)
        {
            return num == 1 ? true : false;
        }

        public sbyte ConvertToTinyInt(bool op) 
        {
            return op ? (sbyte) 1 : (sbyte) 0;
        }
    }
}
