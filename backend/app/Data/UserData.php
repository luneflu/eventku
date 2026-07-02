<?php

namespace App\Data;

use Spatie\LaravelData\Data;
use App\Models\User;

class UserData extends Data
{
    public function __construct(
        public int $id,
        public string $name,
        public string $email,
        public ?string $joined_at = null,
    ) {}

    public static function fromModel(User $user): self
    {
        return new self(
            id: $user->id,
            name: $user->name,
            email: $user->email,
            joined_at: $user->pivot ? $user->pivot->created_at?->toIso8601String() : null,
        );
    }
}
