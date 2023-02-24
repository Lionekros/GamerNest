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
        Schema::create('articles', function (Blueprint $table)
        {
            $table->id();
            $table->string('headline');
            $table->string('summary');
            $table->mediumText('body');
            $table->string('cover');
            $table->boolean('isPublished');
            $table->dateTime('createdDate');
            $table->dateTime('updatedDate')->nullable();

            $table->bigInteger('idAuthor')->unsigned();

            $table->foreign('idAuthor')
                ->references('id')
                ->on('authors')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('articles');
    }
};
