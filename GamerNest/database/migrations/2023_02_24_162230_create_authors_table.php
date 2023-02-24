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
        Schema::create('authors', function (Blueprint $table)
        {
            $table->id()->autoIncrement();
            $table->string('name');
            $table->string('firstLastname');
            $table->string('secondLastname')->nullable();
            $table->char('password', 60);
            $table->string('email')->unique();
            $table->string('phone')->unique();
            $table->text('description');
            $table->string('avatar');
            $table->boolean('admin');
            $table->boolean('canPublish');
            $table->boolean('isActive');
            $table->date('birthday');
            $table->dateTime('startDate');
            $table->dateTime('endDate');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('authors');
    }
};
