<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use Intervention\Image\Alignment;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

class CertificateController extends Controller
{
    public function generate(Event $event)
    {
        $user = auth()->user();

        // 1. Check event finished
        if ($event->status !== 'finished') {
            return response()->json(['message' => 'Event is not finished yet.'], 403);
        }

        // 2. Check user attended
        $participation = $user->participations()->where('event_id', $event->id)->first();
        if (!$participation || !$participation->attended) {
            return response()->json(['message' => 'You did not attend this event.'], 403);
        }

        $templatePath = base_path('../assets/certificate_template.png');
        if (!file_exists($templatePath)) {
            return response()->json(['message' => 'Template not found.'], 500);
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
        $bytes = file_get_contents($path);
        unlink($path);

        return response($bytes)
            ->header('Content-Type', 'image/png')
            ->header('Content-Disposition', 'attachment; filename="certificate_' . $event->id . '.png"');
    }
}
