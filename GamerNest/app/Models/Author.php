<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Author extends Authenticatable
{
    use HasFactory;

    public $timestamps = false;

    public function articles()
    {
        return $this->hasMany(Article::class);
    }
}
