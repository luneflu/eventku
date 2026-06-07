<?php

namespace App\Data;

use Spatie\LaravelData\Data;

class AuthResponseData extends Data
{
    public function __construct(
        public UserData $user,
        public string $token,
    ) {}
}
