<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Post;
use App\Models\User;
use App\Models\PostView;
use Illuminate\Support\Facades\Cache;
use App\Http\Controllers\PostController;





class GetViewController extends Controller
{
    public function get_post_view(Request $data)
    {
        // 該使用者瀏覽的影片
        $postView = Auth::user()->PostView;

        if ($postView->isEmpty()) {
            return response()->json(['error' => '尚未瀏覽影片'], 422);
        }

        // 瀏覽的影片
        $posts = $postView->pluck('post');


        $user_account = $data->user_account;

        if ($user_account) {
            $user = User::where('account', $user_account)->first();

            if (!$user) {
                return response()->json(['error' => '該帳號不存在'], 404);
            }

            $user_id = $user->id;
            $posts = $posts->where('user_id', $user_id);

            if ($posts->isEmpty()) {
                return response()->json(['error' => '使用者尚未瀏覽該帳號的影片'], 422);
            }
        }
        $posts = $posts->filter()->values(); //清null
        $posts = $posts->map(
            function ($item, $key) {
                $postController = new PostController();
                return $postController->tidy_post($item);
            }
        );
        return response()->json(['success' => $posts], 200);
    }

}