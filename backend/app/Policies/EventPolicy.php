<?php

namespace App\Policies;

use App\Models\Event;
use App\Models\User;

class EventPolicy
{
    /**
     * Determine whether the user can update the event.
     */
    public function update(User $user, Event $event): bool
    {
        return $user->id === $event->organizer_id && $event->status === 'draft';
    }

    /**
     * Determine whether the user can publish the event.
     */
    public function publish(User $user, Event $event): bool
    {
        return $user->id === $event->organizer_id && $event->status === 'draft';
    }

    /**
     * Determine whether the user can cancel the event.
     */
    public function cancel(User $user, Event $event): bool
    {
        return $user->id === $event->organizer_id && $event->status !== 'cancelled';
    }

    /**
     * Determine whether the user can finish the event.
     */
    public function finish(User $user, Event $event): bool
    {
        return $user->id === $event->organizer_id && $event->status === 'public';
    }
}
