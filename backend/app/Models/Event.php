<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable([
    'title',
    'description',
    'date',
    'location',
    'organizer_id',
    'status',
    'qr_token',
    'max_capacity',
    'registration_deadline',
])]
class Event extends Model
{
    use HasFactory;

    protected function casts(): array
    {
        return [
            'date' => 'datetime',
            'registration_deadline' => 'datetime',
        ];
    }

    public function organizer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'organizer_id');
    }

    public function participants(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'participations')
            ->withPivot('attended', 'attended_at')
            ->withTimestamps();
    }

    public function participations(): HasMany
    {
        return $this->hasMany(Participation::class);
    }
}
