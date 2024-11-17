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
	public function compareoutput(Request $data)
	{
		$serial = $data->serial;
		$whichoutput = $data->whichoutput;
		$output = $data->output;
		
		$uvaCode = UvaCode::firstWhere('serial', $serial);
		if ($uvaCode) {
			switch ($whichoutput) {
				case 'A':
					$serial_output = $uvaCode->data_a_output;
					break;
				case 'B':
					$serial_output = $uvaCode->data_b_output;
					break;
				default:
					$serial_output = $uvaCode->data_output;
					break;
			}
			
			// 統一換行符為 \n
			$serial_output = str_replace("\r\n", "\n", $serial_output);
			$output = str_replace("\r\n", "\n", $output);
			
			if ($serial_output === $output) {
				return response()->json(['success' => '通過', 'serial_output' => $serial_output, 'output' => $output], 200);
			} else {
				return response()->json(['success' => '不通過', 'serial_output' => $serial_output, 'output' => $output], 200);
			}
		} else {
			return response()->json(['error' => 'Serial not found'], 402);
		}	
	}
}
