<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Author>
 */
class AuthorFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->name(),
            'firstLastName' => $this->faker->firstName(),
            'secondLastName' => $this->faker->firstName(),
            'password' => bcrypt('123456'),
            'email' => $this->faker->email(),
            'phone' => $this->faker->phoneNumber(),
            'description' => $this->faker->text(),
            'avatar' => $this->faker->imageUrl(width: 500, height: 500),
            'admin' => $this->faker->numberBetween($min = 0, $max = 1),
            'canPublish' => 1,
            'isActive' => 1,
            'birthday' => $this->faker->dateTimeBetween($startDate = '-100 years', $endDate = '-50', $timezone = null),
            'startDate' => $this->faker->dateTimeBetween($startDate = '-5 years', $endDate = 'now', $timezone = null),
            'endDate' => null
        ];
    }
}
