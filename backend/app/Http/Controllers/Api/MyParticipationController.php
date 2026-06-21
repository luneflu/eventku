<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Data\EventData;

class MyParticipationController extends Controller
{
    public function index()
    {
        $events = auth()->user()->participatingEvents()
            ->with('organizer')
            ->orderBy('date', 'desc')
            ->paginate();

        return EventData::collect($events);
    }
}
