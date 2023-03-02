<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'username' => $this->faker->userName(),
            'password' => bcrypt('123456'),
            'email' => $this->faker->email(),
            'avatar' => $this->faker->imageUrl(width: 500, height: 500),
            'isConfirmed' => 1,
            'token' => null,
            'birthday' => $this->faker->dateTimeBetween($startDate = '-100 years', $endDate = '-50', $timezone = null),
            'creationDate' => $this->faker->dateTimeBetween($startDate = '-5 years', $endDate = 'now', $timezone = null)
        ];
    }
}
