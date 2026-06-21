<?php

namespace App\Data;

use Spatie\LaravelData\Data;
use App\Models\Event;
use Carbon\Carbon;
use Spatie\LaravelData\Attributes\DataCollectionOf;
use Spatie\LaravelData\DataCollection;

class EventData extends Data
{
    public function __construct(
        public int $id,
        public string $title,
        public string $description,
        public Carbon $date,
        public string $location,
        public string $status,
        public ?string $qr_token,
        public int $max_capacity,
        public Carbon $registration_deadline,
        public int $organizer_id,
        public ?UserData $organizer,
    ) {}

    public static function fromModel(Event $event): self
    {
        return new self(
            id: $event->id,
            title: $event->title,
            description: $event->description,
            date: $event->date,
            location: $event->location,
            status: $event->status,
            qr_token: $event->qr_token,
            max_capacity: $event->max_capacity,
            registration_deadline: $event->registration_deadline,
            organizer_id: $event->organizer_id,
            organizer: $event->relationLoaded('organizer') ? UserData::fromModel($event->organizer) : null,
        );
    }
}
