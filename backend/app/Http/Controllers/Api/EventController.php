<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Data\EventData;
use App\Data\EventCreateRequest;
use App\Data\EventUpdateRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Spatie\QueryBuilder\QueryBuilder;
use Spatie\LaravelData\PaginatedDataCollection;
use Illuminate\Support\Facades\Gate;

class EventController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $events = QueryBuilder::for(Event::class)
            ->where('status', 'public')
            ->allowedFilters('title', 'location')
            ->allowedSorts('date', 'created_at')
            ->defaultSort('date')
            ->with('organizer')
            ->paginate();

        return EventData::collect($events);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(EventCreateRequest $request)
    {
        $event = Event::create([
            ...$request->toArray(),
            'organizer_id' => auth()->id(),
            'status' => 'draft',
            'qr_token' => Str::uuid()->toString(),
        ]);

        return EventData::fromModel($event->load('organizer'));
    }

    /**
     * Display the specified resource.
     */
    public function show(Event $event)
    {
        return EventData::fromModel($event->load(['organizer', 'participants']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(EventUpdateRequest $request, Event $event)
    {
        Gate::authorize('update', $event);

        $event->update($request->toArray());

        return EventData::fromModel($event->load('organizer'));
    }
}
