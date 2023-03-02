<?php

namespace Database\Seeders;

use App\Models\Article;
use App\Models\Author;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ArticlesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        $author = Author::all();
        $author->each(function ($aut)
        {
            Article::factory()->count(3)->create(['idAuthor' => $aut->id]);
        });
    }
}
