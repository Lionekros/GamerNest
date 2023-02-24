<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('game_articles', function (Blueprint $table)
        {
            $table->bigInteger('idGame')->unsigned();
            $table->bigInteger('idArticle')->unsigned();

            $table->foreign('idGame')
                ->references('id')
                ->on('games')
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
        Schema::dropIfExists('game_articles');
    }
};
