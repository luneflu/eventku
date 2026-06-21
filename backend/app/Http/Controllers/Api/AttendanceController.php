<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{
    public function attendByToken(Request $request)
    {
        $request->validate([
            'qr_token' => 'required|string|exists:events,qr_token'
        ]);

        $event = Event::where('qr_token', $request->qr_token)->firstOrFail();
        $user = auth()->user();

        $participation = $user->participations()->where('event_id', $event->id)->first();

        if (!$participation) {
            return response()->json(['message' => 'You are not participating in this event.'], 403);
        }

        if ($participation->attended) {
            return response()->json(['message' => 'Attendance already recorded.'], 200);
        }

        $participation->update([
            'attended' => true,
            'attended_at' => now()
        ]);

        return response()->json(['message' => 'Attendance recorded successfully.']);
    }
}
