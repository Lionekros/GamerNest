<?php

namespace Database\Seeders;

use App\Models\Dev;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DevsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Dev::factory()->count(3)->create();
    }
}
