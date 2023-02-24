<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use HasFactory;

    public $timestamps = false;

    public function scoredGames()
    {
        return $this->belongsToMany(User::class, 'user_score_games');
    }

    public function favoritedGames()
    {
        return $this->belongsToMany(User::class, 'user_fav_games');
    }
}
