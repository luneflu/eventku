<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Event;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Spatie\QueryBuilder\QueryBuilder;

class AdminController extends Controller
{
    public function users(): JsonResponse
    {
        $users = QueryBuilder::for(User::class)
            ->allowedFilters('name', 'email', 'role', 'is_banned')
            ->allowedSorts('id', 'name', 'created_at')
            ->defaultSort('-created_at')
            ->paginate();

        return response()->json($users);
    }

    public function toggleUserBan(User $user): JsonResponse
    {
        if ($user->role === 'admin') {
            return response()->json(['message' => 'Cannot ban an admin user.'], 403);
        }

        $user->is_banned = !$user->is_banned;
        $user->save();

        return response()->json($user);
    }

    public function events(): JsonResponse
    {
        $events = QueryBuilder::for(Event::class)
            ->with(['organizer'])
            ->allowedFilters('title', 'status', 'is_banned')
            ->allowedSorts('id', 'date', 'created_at')
            ->defaultSort('-created_at')
            ->paginate();

        return response()->json($events);
    }

    public function toggleEventBan(Event $event): JsonResponse
    {
        $event->is_banned = !$event->is_banned;
        $event->save();

        return response()->json($event);
    }
}
