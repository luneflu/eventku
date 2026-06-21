<?php

namespace App\Data;

use Spatie\LaravelData\Data;

class AttendRequest extends Data
{
    public function __construct(
        public string $qr_token,
    ) {}
}
