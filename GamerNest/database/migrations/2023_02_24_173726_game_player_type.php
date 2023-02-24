<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('game_player_types', function (Blueprint $table)
        {
            $table->bigInteger('idGame')->unsigned();
            $table->bigInteger('idPlayerType')->unsigned();

            $table->foreign('idGame')
                ->references('id')
                ->on('games')
                ->onDelete('cascade');

            $table->foreign('idPlayerType')
                ->references('id')
                ->on('player_types')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('game_player_types');
    }
};
