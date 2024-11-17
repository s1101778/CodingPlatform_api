<?php

namespace App\Http\Controllers;

use App\Models\UvaTopic;
use App\Models\User;
use App\Models\Post;
use Illuminate\Support\Facades\DB;

class UvaController extends Controller
{
    public function get_uva()
    {
        $UvaTopic = UvaTopic::all();
        return response()->json(['success' => $UvaTopic], 200);
    }
    public function get_uva_pdf($serial)
    {
        if (UvaTopic::firstWhere('serial', $serial)) {
            $topic_pdf = UvaTopic::firstWhere('serial', $serial)->topic_url;
            $tempFile = tempnam(sys_get_temp_dir(), $serial);
            copy($topic_pdf, $tempFile);
            return response()->file($tempFile);
        } else {
            return response()->json(['error' => 'Serial not found'], 402);

        }
    }
}
