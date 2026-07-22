<?php

namespace App\Services;

use App\Models\Event;
use App\Models\User;
use Intervention\Image\Alignment;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

class CertificateService
{
    public function generate(Event $event, User $user): string
    {
        $templatePath = storage_path('app/assets/Certificate-Template.png');
        if (!file_exists($templatePath)) {
            throw new \Exception('Template not found.');
        }

        $manager = ImageManager::usingDriver(Driver::class);
        $image = $manager->decodePath($templatePath);

        $width = $image->width();

        // Name
        $nameFontPath = storage_path('app/fonts/PlaywriteUSTrad-Regular.ttf');
        $image->text($user->name, $width / 2, 730, function ($font) use ($nameFontPath) {
            $font->filepath($nameFontPath);
            $font->size(72);
            $font->color('#254d70');
            $font->align(Alignment::CENTER, Alignment::CENTER);
        });

        // Event Title
        $titleFontPath = storage_path('app/fonts/Poppins-SemiBold.ttf');
        $image->text("\"{$event->title}\"", $width / 2, 920, function ($font) use ($titleFontPath) {
            $font->filepath($titleFontPath);
            $font->size(32);
            $font->color('#fff');
            $font->align(Alignment::CENTER, Alignment::CENTER);
        });

        // Date
        $dateFontPath = storage_path('app/fonts/Poppins-Medium.ttf');
        $image->text($event->date->format('j F Y'), $width / 2, 1000, function ($font) use ($dateFontPath) {
            $font->filepath($dateFontPath);
            $font->size(24);
            $font->color('#254d70');
            $font->align(Alignment::CENTER, Alignment::CENTER);
        });

        $path = storage_path('app/public/certificate_' . $event->id . '_' . $user->id . '.png');
        $image->save($path);

        return $path;
    }
}
