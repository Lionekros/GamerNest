<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    use HasFactory;

    public $timestamps = false;

    public function games()
    {
        return $this->belongsToMany(Game::class);
    }
    public function author()
    {
        return $this->belongsTo(Author::class);
    }
}
