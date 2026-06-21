<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Data\EventData;
use Illuminate\Http\Request;
use Spatie\QueryBuilder\QueryBuilder;

class MyEventController extends Controller
{
    public function index(Request $request)
    {
        $events = QueryBuilder::for(Event::class)
            ->where('organizer_id', $request->user()->id)
            ->allowedFilters('status', 'title')
            ->allowedSorts('date', 'created_at')
            ->defaultSort('-created_at')
            ->paginate();

        return EventData::collect($events);
    }
}
