<?php

namespace App\Http\Controllers;

use App\Models\UserSubscribe;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Post;
use App\Models\User;
use Illuminate\Support\Facades\Cache;
use App\Http\Controllers\PostController;

class GetSubscribeController extends Controller
{
    public function get_subscribe(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'post_id' => 'required|exists:posts,id',
        ], [
            'required' => '欄位沒有填寫完整',
            'post_id.exists' => '影片不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user_post_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'post_id' => $data->post_id
        ])->first()?->subscribe;
        return response()->json(['user_post_subscribe' => $user_post_subscribe], 200);
    }

    // 訂閱影片功能
    public function subscribe_post(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'author_id' => 'required|exists:posts,id',
            'subscribe' => 'required'
        ], [
            'required' => '欄位沒有填寫完整',
            'author_id.exists' => '影片不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        $subscribe = $data->subscribe;
        if ($subscribe != 0 && $subscribe != 1) {
            return response()->json(['error' => 'subscribe 只限於 0 or 1'], 422);
        }
        $user_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'author_id' => $data->author_id,
        ])->first();
        $post = Post::find($data->author_id);
        if ($user_subscribe === null) {     // 建立新訂閱
            if ($subscribe == 1) {
                UserSubscribe::create([
                    'user_id' => Auth::user()->id,
                    'author_id' => $data->author_id,
                    'subscribe' => $subscribe,
                ]);
                // $post->increment('subscribes');  post 沒有訂閱
                Auth::user()->increment('subscriptions');
            }
        } else {    // 取消訂閱
            if ($subscribe == 0 && $user_subscribe->subscribe == 1) {
                $user_subscribe->delete();
                // $post->decrement('subscribes');  post 沒有訂閱
                Auth::user()->decrement('subscriptions');
            }
        }
        $user_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'author_id' => $data->author_id,
        ])->first();

        $now_post_subscribe = Post::find($data->author_id)->subscribes;

        return response()->json(['success' => '更新訂閱狀態成功', 'user_post_subscribe' => $user_subscribe?->subscribe, 'now_post_subscribe' => $now_post_subscribe], 200);

    }


    public function get_subscribe_post(Request $data)
    {
        // 獲取當前用戶的 ID
        $userId = Auth::id(); // 或者 Auth::user()->id

        // 檢查是否提供了 user_account
        if ($data->user_account) {
            // 查詢該帳號的用戶
            $user = User::where('account', $data->user_account)->first();

            // 如果用戶不存在，返回錯誤
            if (!$user) {
                return response()->json(['error' => '該帳號不存在'], 404);
            }

            $userId = $user->id;
        }

        // 查詢該用戶的訂閱記錄
        $postsQuery = UserSubscribe::where('user_id', $userId);
        $posts = $postsQuery->get(); // 使用 get() 方法獲取結果

        // 檢查是否有訂閱記錄
        if ($posts->isEmpty()) {
            if ($data->user_account) {
                return response()->json(['error' => '使用者尚未收藏該帳號的影片'], 422);
            } else {
                return response()->json(['error' => '尚未收藏'], 404);
            }
        }

        // 過濾掉空值並映射處理
        $posts = $posts->filter()->map(function ($item) {
            $postController = new PostController();
            return $postController->tidy_post($item);
        });

        return response()->json(['success' => $posts->values()], 200);
    }
}