<?php

namespace App\Data;

use App\Models\User;
use Spatie\LaravelData\Data;

class UserData extends Data
{
    public function __construct(
        public int $id,
        public string $name,
        public string $email,
        public string $role,
        public bool $is_banned,
        public ?string $joined_at = null,
    ) {}

    public static function fromModel(User $user): self
    {
        return new self(
            id: $user->id,
            name: $user->name,
            email: $user->email,
            role: $user->role,
            is_banned: $user->is_banned,
            joined_at: $user->pivot ? $user->pivot->created_at?->toIso8601String() : null,
        );
    }
}
