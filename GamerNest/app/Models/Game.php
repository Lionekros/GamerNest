<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Game extends Model
{
    use HasFactory;

    public $timestamps = false;

    public function genres()
    {
        return $this->belongsToMany(Genre::class);
    }

    public function languages()
    {
        return $this->belongsToMany(Language::class);
    }

    public function player_types()
    {
        return $this->belongsToMany(PlayerType::class);
    }

    public function scoredUsers()
    {
        return $this->belongsToMany(User::class, 'user_score_games');
    }

    public function favoritedByUsers()
    {
        return $this->belongsToMany(User::class, 'user_fav_games');
    }

    public function articles()
    {
        return $this->belongsToMany(Article::class);
    }

    public function platforms()
    {
        return $this->hasOne(Platform::class);
    }

    public function dev()
    {
        return $this->hasOne(Dev::class);
    }

    public function publisher()
    {
        return $this->hasOne(Publisher::class);
    }
}
