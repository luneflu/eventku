<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Data\EventData;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class EventStatusController extends Controller
{
    public function publish(Event $event)
    {
        Gate::authorize('publish', $event);

        $event->update(['status' => 'public']);

        return EventData::fromModel($event->load('organizer'));
    }

    public function cancel(Event $event)
    {
        Gate::authorize('cancel', $event);

        $event->update(['status' => 'cancelled']);

        return EventData::fromModel($event->load('organizer'));
    }

    public function finish(Event $event)
    {
        Gate::authorize('finish', $event);

        $event->update(['status' => 'finished']);

        return EventData::fromModel($event->load('organizer'));
    }
}
