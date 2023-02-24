<?php

namespace Database\Seeders;

use App\Models\PlayerType;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PlayerTypesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        PlayerType::factory()->count(3)->create();
    }
}
