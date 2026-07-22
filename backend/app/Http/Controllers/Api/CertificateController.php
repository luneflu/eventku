<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Services\CertificateService;

class CertificateController extends Controller
{
    public function __construct(private CertificateService $certificateService)
    {
    }

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

        try {
            $path = $this->certificateService->generate($event, $user);
            $bytes = file_get_contents($path);
            
            return response($bytes)
                ->header('Content-Type', 'image/png')
                ->header('Content-Disposition', 'attachment; filename="certificate_' . $event->id . '.png"');
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 500);
        }
    }
}
