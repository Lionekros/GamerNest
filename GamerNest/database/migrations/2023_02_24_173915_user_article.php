<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_articles', function (Blueprint $table)
        {
            $table->bigInteger('idUser')->unsigned();
            $table->bigInteger('idArticle')->unsigned();

            $table->foreign('idUser')
                ->references('id')
                ->on('users')
                ->onDelete('cascade');

            $table->foreign('idArticle')
                ->references('id')
                ->on('articles')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_fav_games');
    }
};
