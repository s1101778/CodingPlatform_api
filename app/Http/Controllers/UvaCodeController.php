<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\UvaCode;
use App\Models\User;
use App\Models\Post;
use Illuminate\Support\Facades\DB;

class UvaCodeController extends Controller
{
    public function get_uva_code()
    {

        $UvaCode = UvaCode::all();
        return response()->json(['success' => $UvaCode], 200);
    }
    public function get_uva_code_pdf($serial)
    {
        if (UvaCode::firstWhere('serial', $serial)) {
            $topic_pdf = UvaCode::firstWhere('serial', $serial)->topic_url;
            $tempFile = tempnam(sys_get_temp_dir(), $serial);
            copy($topic_pdf, $tempFile);
            return response()->file($tempFile);
        } else
            return response()->json(['error' => 'Serial not found'], 402);
    }
}
