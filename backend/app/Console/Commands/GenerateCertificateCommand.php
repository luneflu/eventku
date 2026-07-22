<?php

namespace App\Console\Commands;

use Illuminate\Console\Attributes\Description;
use Illuminate\Console\Attributes\Signature;
use Illuminate\Console\Command;
use App\Models\Event;
use App\Models\User;
use App\Services\CertificateService;

#[Signature('certificate:generate {event_id} {user_id}')]
#[Description('Generate a certificate for testing')]
class GenerateCertificateCommand extends Command
{
    public function __construct(private CertificateService $certificateService)
    {
        parent::__construct();
    }

    public function handle()
    {
        $eventId = $this->argument('event_id');
        $userId = $this->argument('user_id');

        $event = Event::findOrFail($eventId);
        $user = User::findOrFail($userId);

        try {
            $path = $this->certificateService->generate($event, $user);
            $this->info("Certificate saved at: " . $path);
        } catch (\Exception $e) {
            $this->error($e->getMessage());
        }
    }
}
