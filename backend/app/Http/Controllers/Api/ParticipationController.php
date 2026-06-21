<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Models\Participation;
use App\Data\AttendRequest;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class ParticipationController extends Controller
{
    public function store(Request $request, Event $event)
    {
        if ($event->status !== 'public') {
            throw ValidationException::withMessages(['event' => 'Event is not public.']);
        }

        if (now()->isAfter($event->registration_deadline)) {
            throw ValidationException::withMessages(['event' => 'Registration deadline has passed.']);
        }

        if ($event->participations()->count() >= $event->max_capacity) {
            throw ValidationException::withMessages(['event' => 'Event is at full capacity.']);
        }

        $participation = Participation::firstOrCreate([
            'user_id' => $request->user()->id,
            'event_id' => $event->id,
        ]);

        return response()->json(['message' => 'Successfully registered for event.', 'participation' => $participation]);
    }

    public function destroy(Request $request, Event $event)
    {
        Participation::where('user_id', $request->user()->id)
            ->where('event_id', $event->id)
            ->delete();

        return response()->json(['message' => 'Successfully cancelled participation.']);
    }

    public function attend(AttendRequest $request, Event $event)
    {
        if ($event->qr_token !== $request->qr_token) {
             throw ValidationException::withMessages(['qr_token' => 'Invalid QR token.']);
        }

        $participation = Participation::where('user_id', request()->user()->id)
            ->where('event_id', $event->id)
            ->first();

        if (!$participation) {
             throw ValidationException::withMessages(['event' => 'You are not registered for this event.']);
        }

        if ($participation->attended) {
             throw ValidationException::withMessages(['event' => 'You have already attended this event.']);
        }

        $participation->update([
            'attended' => true,
            'attended_at' => now(),
        ]);

        return response()->json(['message' => 'Attendance recorded successfully.', 'participation' => $participation]);
    }
}
