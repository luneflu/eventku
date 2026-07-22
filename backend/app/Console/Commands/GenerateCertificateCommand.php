<?php

namespace App\Console\Commands;

use Illuminate\Console\Attributes\Description;
use Illuminate\Console\Attributes\Signature;
use Illuminate\Console\Command;
use App\Models\Event;
use App\Models\User;
use Intervention\Image\Alignment;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

#[Signature('certificate:generate {event_id} {user_id}')]
#[Description('Generate a certificate for testing')]
class GenerateCertificateCommand extends Command
{
    public function handle()
    {
        $eventId = $this->argument('event_id');
        $userId = $this->argument('user_id');

        $event = Event::findOrFail($eventId);
        $user = User::findOrFail($userId);

        $templatePath = base_path('../assets/certificate_template.png');
        if (!file_exists($templatePath)) {
            $this->error('Template not found.');
            return;
        }

        $manager = ImageManager::usingDriver(Driver::class);
        $image = $manager->decodePath($templatePath);

        // Name
        $fontPath = base_path('../assets/fonts/arial.ttf');
        $image->text($user->name, 400, 300, function ($font) use ($fontPath) {
            $font->filepath($fontPath);
            $font->size(48);
            $font->color('#000');
            $font->align(Alignment::CENTER, Alignment::CENTER);
        });

        // Event Title
        $image->text($event->title, 400, 400, function ($font) use ($fontPath) {
            $font->filepath($fontPath);
            $font->size(32);
            $font->color('#000');
            $font->align(Alignment::CENTER, Alignment::CENTER);
        });

        // Organizer
        $image->text("Organizer: " . $event->organizer->name, 400, 450, function ($font) use ($fontPath) {
            $font->filepath($fontPath);
            $font->size(24);
            $font->color('#000');
            $font->align(Alignment::CENTER, Alignment::CENTER);
        });

        // Date
        $image->text("Date: " . $event->date->format('Y-m-d'), 400, 500, function ($font) use ($fontPath) {
            $font->filepath($fontPath);
            $font->size(24);
            $font->color('#000');
            $font->align(Alignment::CENTER, Alignment::CENTER);
        });

        $path = storage_path('app/public/certificate_' . $event->id . '.png');
        $image->save($path);
        
        $this->info("Certificate saved at: " . $path);
    }
}
