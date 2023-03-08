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
        public long idUser { get; set; }
        public List<UserFavGameModel> gameFavList { get; set; }

        public UserFavGameModel(DataRow row) 
        { 
            gameFavList = new List<UserFavGameModel>();
        }
    }
}
