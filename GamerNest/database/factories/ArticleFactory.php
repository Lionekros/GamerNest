<?php

namespace Database\Factories;

use App\Models\Author;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Article>
 */
class ArticleFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'headline' => $this->faker->sentence(),
            'summary' => $this->faker->text(maxNbChars: 255),
            'body' => $this->faker->text(),
            'cover' => $this->faker->imageUrl(width: 500, height: 500),
            'isPublished' => 1,
            'createdDate' => $this->faker->dateTimeBetween($startDate = '-100 years', $endDate = '-50', $timezone = null),
            'updatedDate' => $this->faker->dateTimeBetween($startDate = '-100 years', $endDate = '-50', $timezone = null)
        ];
    }
}
