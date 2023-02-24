<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('game_languages', function (Blueprint $table)
        {
            $table->bigInteger('idGame')->unsigned();
            $table->bigInteger('idLanguage')->unsigned();

            $table->foreign('idGame')
                ->references('id')
                ->on('games')
                ->onDelete('cascade');

            $table->foreign('idLanguage')
                ->references('id')
                ->on('languages')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('game_languages');
    }
};
