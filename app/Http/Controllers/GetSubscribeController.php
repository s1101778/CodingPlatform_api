<?php

namespace App\Http\Controllers;

use App\Models\UserSubscribe;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Post;
use App\Models\User;
use Illuminate\Support\Facades\Cache;
class GetSubscribeController extends Controller
{
    public function get_subscribe(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'post_id' => 'required|exists:posts,id',
        ], [
            'required' => '欄位沒有填寫完整',
            'post_id.exists' => '貼文不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }

        $user_post_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'post_id' => $data->post_id
        ])->first()?->subscribe;
        return response()->json(['user_post_subscribe' => $user_post_subscribe], 200);
    }
}
