<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('game_genres', function (Blueprint $table)
        {
            $table->bigInteger('idGame')->unsigned();
            $table->bigInteger('idGenre')->unsigned();

            $table->foreign('idGame')
                ->references('id')
                ->on('games')
                ->onDelete('cascade');

            $table->foreign('idGenre')
                ->references('id')
                ->on('genres')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('game_genres');
    }
};
