<?php

namespace App\Console\Commands;

use App\Models\Record;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;

class UpdateStreamTimes extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:update-stream-times';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Check if specified Twitch streams are live';

    /**
     * The Twitch streams to check.
     *
     * @var array
     */
    protected $streams = ['midzui', 'jhulzui'];

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $token = $this->getToken();
        if ($this->isStreaming($token)) {
            $record = Record::find(1);
            $record->last_stream = date('Y-m-d H:i:s');
            $record->save();

            $this->info('Stream is live! Last stream time updated.');
        } else {
            $this->info('Streams are not currently live.');
        }

        return Command::SUCCESS;
    }

    /**
     * Get an access token from Twitch.
     *
     * @return string
     */
    private function getToken()
    {
        $response = Http::asForm()->post('https://id.twitch.tv/oauth2/token', [
            'client_id' => config('services.twitch.client_id'),
            'client_secret' => config('services.twitch.client_secret'),
            'grant_type' => 'client_credentials',
        ]);

        return $response->json('access_token');
    }

    /**
     * Check if any of the specified streams are live.
     *
     * @param  string  $token
     * @return bool
     */
    private function isStreaming(string $token)
    {
        $response = Http::withHeaders([
            'Client-ID' => config('services.twitch.client_id'),
            'Authorization' => "Bearer {$token}",
        ])->get('https://api.twitch.tv/helix/streams', [
            'user_login' => $this->streams,
        ]);

        return $response->json('data') != []; // Check if data array is not empty
    }
}
