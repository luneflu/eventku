<?php

namespace App\Data;

use Spatie\LaravelData\Data;
use Carbon\Carbon;
use Spatie\LaravelData\Attributes\Validation\Min;
use Spatie\LaravelData\Attributes\Validation\After;

class EventUpdateRequest extends Data
{
    public function __construct(
        public string $title,
        public string $description,
        #[After('now')]
        public Carbon $date,
        public string $location,
        #[Min(1)]
        public int $max_capacity,
        #[After('now')]
        public Carbon $registration_deadline,
    ) {}
}
