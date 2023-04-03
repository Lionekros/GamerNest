using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Support
{
    public class AdminLogIn
    {
        [Required( ErrorMessage = "Required" )]
        public string email { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string password { get; set; }
    }
}
