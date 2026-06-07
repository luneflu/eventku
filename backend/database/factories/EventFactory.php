<?php

namespace Database\Factories;

use App\Models\Event;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends Factory<Event>
 */
class EventFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $date = fake()->dateTimeBetween('+1 week', '+2 months');
        // registration deadline is 1 to 3 days before event date
        $registrationDeadline = (clone $date)->modify('-' . rand(1, 3) . ' days');

        return [
            'title' => fake()->sentence(4),
            'description' => fake()->paragraph(3),
            'date' => $date,
            'location' => fake()->address(),
            'organizer_id' => User::factory(),
            'status' => fake()->randomElement(['draft', 'public', 'cancelled', 'finished']),
            'qr_token' => (string) Str::uuid(),
            'max_capacity' => fake()->numberBetween(10, 100),
            'registration_deadline' => $registrationDeadline,
        ];
    }
}
