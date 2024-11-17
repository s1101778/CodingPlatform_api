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


        $user_id = $data->author_id;
		
		if($user_id) {
			$posts = $posts->where('user_id', $user_id);
			
			if ($posts->isEmpty()) {
                return response()->json(['error' => '使用者尚未瀏覽過該帳號的任何影片'], 402);
            }
		}
		
		$posts = $posts->sortByDesc('updated_at');
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