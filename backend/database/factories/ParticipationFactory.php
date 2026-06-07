<?php

namespace Database\Factories;

use App\Models\Event;
use App\Models\Participation;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Participation>
 */
class ParticipationFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $attended = fake()->boolean(50);

        return [
            'user_id' => User::factory(),
            'event_id' => Event::factory(),
            'attended' => $attended,
            'attended_at' => $attended ? fake()->dateTimeThisMonth() : null,
        ];
    }
}
