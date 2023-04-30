﻿using DBAccess;
using LogError;
using Support;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain
{
    public class ArticleService
    {
        public static List<ArticleModel> GetAllArticles(string language = "ENG", string orderBy = "" )
        {
            try
            {
                DataTable dt = ArticleRepository.GetAllArticles(language, orderBy);
                List<ArticleModel> list = new List<ArticleModel>();

                foreach ( DataRow row in dt.Rows )
                {
                    list.Add( new ArticleModel( row ) );
                }

                return list;
            }
            catch ( Exception ex )
            {
                List<ArticleModel> list = new List<ArticleModel>();
                Log log = new Log();
                log.Add( ex.Message );
                return list;

            }
        }
    }
}
