<?php

namespace Database\Factories;

use App\Models\Dev;
use App\Models\Platform;
use App\Models\Publisher;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Game>
 */
class GameFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'title' => $this->faker->sentence(),
            'subtitle' => $this->faker->sentence(),
            'description' => $this->faker->text(maxNbChars: 500),
            'cover' => $this->faker->imageUrl(width: 1000, height: 500),
            'releaseDate' => $this->faker->dateTimeBetween($startDate = '-100 years', $endDate = '-50', $timezone = null),
            'totalScore' => 0,
            'approved' => 1,
            'idPlatform' => Platform::inRandomOrder()->first(),
            'idPublisher' => Publisher::inRandomOrder()->first(),
            'idDev' => Dev::inRandomOrder()->first()
        ];
    }
}
