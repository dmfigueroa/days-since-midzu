<?php

use Illuminate\Support\Facades\Route;
use App\Models\Record;
use Carbon\Carbon;

Route::get('/', function () {
    $record = Record::find(1);
    $last_stream_days = floor(Carbon::parse($record->last_stream)->diffInDays());
    $said_days = floor(Carbon::parse($record->said)->diffInDays());

    return view('welcome', ['last_stream' => $last_stream_days, 'said' => $said_days]);
});
