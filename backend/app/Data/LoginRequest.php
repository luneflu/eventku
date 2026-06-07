<?php

namespace App\Data;

use Spatie\LaravelData\Data;

class LoginRequest extends Data
{
    public function __construct(
        public string $email,
        public string $password,
    ) {}

    public static function rules(): array
    {
        return [
            'email' => ['required', 'string', 'email'],
            'password' => ['required', 'string'],
        ];
    }
}
