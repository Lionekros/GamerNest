﻿using System.ComponentModel.DataAnnotations;
using System.Data;

namespace Support
{
    public class CategoryModel
    {
        public int id { get; set; }

        [Required( ErrorMessage = "Required" )]
        public string name { get; set; }

        public CategoryModel()
        {
        }

        public CategoryModel(DataRow row)
        {
            id = row.Field<int>( "id" );
            name = row.Field<string>( "name" );
        }
    }
}
