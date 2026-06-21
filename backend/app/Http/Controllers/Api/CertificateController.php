<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;
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

        $manager = new ImageManager(new Driver());
        $image = $manager->read($templatePath);

        // Name
        $image->text($user->name, 400, 300, function ($font) {
            $font->size(48);
            $font->color('#000');
            $font->align('center');
            $font->valign('middle');
        });

        // Event Title
        $image->text($event->title, 400, 400, function ($font) {
            $font->size(32);
            $font->color('#000');
            $font->align('center');
            $font->valign('middle');
        });

        // Organizer
        $image->text("Organizer: " . $event->organizer->name, 400, 450, function ($font) {
            $font->size(24);
            $font->color('#000');
            $font->align('center');
            $font->valign('middle');
        });

        // Date
        $image->text("Date: " . $event->date->format('Y-m-d'), 400, 500, function ($font) {
            $font->size(24);
            $font->color('#000');
            $font->align('center');
            $font->valign('middle');
        });

        $encoded = $image->toPng();
        
        return response($encoded)
            ->header('Content-Type', 'image/png')
            ->header('Content-Disposition', 'attachment; filename="certificate_'.$event->id.'.png"');
    }
}
