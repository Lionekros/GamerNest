<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('user_fav_games', function (Blueprint $table)
        {
            $table->bigInteger('idGame')->unsigned();
            $table->bigInteger('idUser')->unsigned();

            $table->foreign('idGame')
                ->references('id')
                ->on('games')
                ->onDelete('cascade');

            $table->foreign('idUser')
                ->references('id')
                ->on('users')
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
