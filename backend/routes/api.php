<?php
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\EventController;
use App\Http\Controllers\Api\MyEventController;
use App\Http\Controllers\Api\EventStatusController;
use App\Http\Controllers\Api\ParticipationController;
use Illuminate\Support\Facades\Route;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/events', [EventController::class, 'index']);
Route::get('/events/{event}', [EventController::class, 'show']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/profile', [AuthController::class, 'profile']);

    Route::post('/events', [EventController::class, 'store']);
    Route::put('/events/{event}', [EventController::class, 'update']);
    
    Route::get('/my-events', [MyEventController::class, 'index']);

    Route::post('/events/{event}/publish', [EventStatusController::class, 'publish']);
    Route::post('/events/{event}/cancel', [EventStatusController::class, 'cancel']);
    Route::post('/events/{event}/finish', [EventStatusController::class, 'finish']);

    Route::post('/events/{event}/participate', [ParticipationController::class, 'store']);
    Route::delete('/events/{event}/participate', [ParticipationController::class, 'destroy']);
    Route::post('/events/{event}/attend', [ParticipationController::class, 'attend']);
});
