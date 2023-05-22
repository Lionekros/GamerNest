using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class UserFavGameModel
    {
        public int idUser { get; set; }
        public int idGame { get; set; }

        public UserFavGameModel(DataRow row) 
        { 
        }
    }
}
