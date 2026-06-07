<?php

namespace Database\Seeders;

use App\Models\Event;
use App\Models\Participation;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Create a Test User
        $testUser = User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
            'password' => bcrypt('password'),
        ]);

        // 2. Create other Users
        $users = User::factory(15)->create();
        $allUsers = collect([$testUser])->concat($users);

        // 3. Create Events organized by the Test User
        $testUserEvents = collect();
        $statuses = ['draft', 'public', 'cancelled', 'finished'];
        foreach ($statuses as $index => $status) {
            $testUserEvents->push(Event::factory()->create([
                'title' => "Test User Event " . ucfirst($status),
                'organizer_id' => $testUser->id,
                'status' => $status,
                // Make finished event in the past, others in the future
                'date' => $status === 'finished' ? now()->subDays(5) : now()->addDays(($index + 1) * 5),
                'registration_deadline' => $status === 'finished' ? now()->subDays(7) : now()->addDays(($index + 1) * 3),
            ]));
        }

        // 4. Create Events organized by other Users
        $otherEvents = collect();
        foreach ($users as $index => $organizer) {
            $status = $statuses[$index % count($statuses)];
            $otherEvents->push(Event::factory()->create([
                'organizer_id' => $organizer->id,
                'status' => $status,
                'date' => $status === 'finished' ? now()->subDays(rand(1, 10)) : now()->addDays(rand(1, 30)),
                'registration_deadline' => $status === 'finished' ? now()->subDays(rand(11, 15)) : now()->addDays(rand(1, 20)),
            ]));
        }

        $allEvents = $testUserEvents->concat($otherEvents);

        // 5. Create Participations (ensure unique constraint user_id + event_id)
        foreach ($allEvents as $event) {
            if ($event->status === 'draft') {
                // Draft events shouldn't have participants yet
                continue;
            }

            // Exclude the organizer from participating in their own event
            $potentialParticipants = $allUsers->reject(fn($u) => $u->id === $event->organizer_id);

            // Let a random number of users participate (up to max_capacity)
            $participantCount = min(rand(2, 8), $event->max_capacity, $potentialParticipants->count());
            $participants = $potentialParticipants->random($participantCount);

            foreach ($participants as $participant) {
                $attended = $event->status === 'finished' ? (rand(0, 100) > 30) : false;

                Participation::create([
                    'user_id' => $participant->id,
                    'event_id' => $event->id,
                    'attended' => $attended,
                    'attended_at' => $attended ? $event->date->addMinutes(rand(5, 30)) : null,
                ]);
            }
        }
    }
}
