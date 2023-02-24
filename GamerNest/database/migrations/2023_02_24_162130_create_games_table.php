<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('games', function (Blueprint $table)
        {
            $table->id()->autoIncrement();
            $table->string('title');
            $table->string('subtitle');
            $table->text('description');
            $table->string('cover');
            $table->date('releaseDate');
            $table->tinyInteger('totalScore')->default(0);
            $table->boolean('approved');

            $table->bigInteger('idPlatform')->unsigned();
            $table->bigInteger('idPublisher')->unsigned();
            $table->bigInteger('idDev')->unsigned();

            $table->foreign('idPlatform')
                ->references('id')
                ->on('platforms')
                ->onDelete('cascade');

            $table->foreign('idPublisher')
                ->references('id')
                ->on('publishers')
                ->onDelete('cascade');

            $table->foreign('idDev')
                ->references('id')
                ->on('devs')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('games');
    }
};
