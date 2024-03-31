<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Post;
use App\Models\User;
use App\Models\UserLike;
use Illuminate\Support\Facades\Cache;

class GetLikeController extends Controller
{
    public function get_like(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'post_id' => 'required|exists:post,id',
        ], [
            'required' => '欄位沒有填寫完整',
            'post_id.exists' => '貼文不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 403);
        }

        $user_post_like = UserLike::where([
            'user_id' => Auth::user()->id,
            'post_id' => $data->post_id
        ])->whereNull('comment_id')->first()?->dislike_or_like;

        $user_comment_like = UserLike::where([
            'user_id' => Auth::user()->id,
            'post_id' => $data->post_id
        ])->whereNotNull('comment_id')->get();
        return response()->json(['user_post_like' => $user_post_like, 'user_comment_like' => $user_comment_like], 200);
    }
}
