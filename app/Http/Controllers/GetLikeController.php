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
use App\Http\Controllers\PostController;


class GetLikeController extends Controller
{
    // 顯示使用者影片的整體喜歡情況以及針對每個留言的喜歡情況
    public function get_like(Request $data)
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


    public function like_post(Request $data)
    {
        $lock = Cache::lock('key', 5);
        if (!$lock->get()) {
            return response()->json(['error' => '操作過於頻繁'], 429);
        }
        $validator = Validator::make($data->all(), [
            'post_id' => 'required|exists:posts,id',
            'dislike_or_like' => 'required',
        ], [
            'required' => '欄位沒有填寫完整!',
            'post_id.exists' => '影片不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        $dislike_or_like = $data->dislike_or_like;
        if ($dislike_or_like != 1 && $dislike_or_like != -1) {
            return response()->json(['error' => 'dislike_or_like只限於-1 or 1'], 422);
        }
        $user_like = UserLike::where([
            'user_id' => Auth::user()->id,
            'post_id' => $data->post_id,
        ])->whereNull('comment_id')->first();

        $post = Post::find($data->post_id);

        if ($user_like == null) {
            UserLike::create([
                'user_id' => Auth::user()->id,
                'post_id' => $data->post_id,
                'dislike_or_like' => $dislike_or_like,
            ]);
            if ($dislike_or_like == 1) {
                $post->increment('likes');
            } else if ($dislike_or_like == -1) {
                $post->decrement('likes');
            }
        } else {
            if ($dislike_or_like == 1 && $user_like->dislike_or_like == -1) {
                $user_like->delete();
                $post->increment('likes');
            } else if ($dislike_or_like == -1 && $user_like->dislike_or_like == 1) {
                $user_like->delete();
                $post->decrement('likes');
            }
        }
        $user_like = UserLike::where([
            'user_id' => Auth::user()->id,
            'post_id' => $data->post_id,
        ])->whereNull('comment_id')->first();

        $now_post_like = Post::find($data->post_id)->likes;
        $lock->release();

        return response()->json(['success' => '更新喜歡狀態成功', 'user_post_like' => $user_like?->dislike_or_like, 'now_post_like' => $now_post_like], 200);
    }

    // 取得目前使用者喜歡的影片，並根據指定的使用者帳號過濾結果，最後傳回符合條件的影片數據
    public function get_like_post(Request $data)
    {
        $user = Auth::user();

        // 取得屬於當前用戶且 dislike_or_like 等於 1 的 UserLike 記錄
        $userLikes = UserLike::where(['user_id' => $user->id, 'dislike_or_like' => 1])->get();

        // 檢查是否有喜歡
        if ($userLikes->isEmpty()) {
            return response()->json(['error' => '尚未喜歡'], 404);
        }

        // 提取喜歡的影片
        $posts = $userLikes->pluck('post');

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





    public function like_comment(Request $data)
    {
        $lock = Cache::lock('key', 5);
        if (!$lock->get()) {
            return response()->json(['error' => '操作過於頻繁'], 429);
        }
        $validator = Validator::make($data->all(), [
            'comment_id' => 'required|exists:comments,id',
            'dislike_or_like' => 'required', //-1 1
        ], [
            'required' => '欄位沒有填寫完整!',
            'comment_id.exists' => '評論不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        $dislike_or_like = $data->dislike_or_like;
        if ($dislike_or_like != 1 && $dislike_or_like != -1) {
            return response()->json(['error' => 'dislike_or_like只限於-1 or 1'], 422);
        }
        $user_like = UserLike::where([
            'user_id' => Auth::user()->id,
            'comment_id' => $data->comment_id,
        ])->first();
        $comment = Comment::find($data->comment_id);
        if ($user_like === null) {
            UserLike::create([
                'user_id' => Auth::user()->id,
                'post_id' => $comment->post_id,
                'comment_id' => $data->comment_id,
                'dislike_or_like' => $dislike_or_like,
            ]);
            if ($dislike_or_like == 1) {
                $comment->increment('likes');
            } else if ($dislike_or_like == -1) {
                $comment->decrement('likes');
            }
        } else {
            if ($dislike_or_like == 1 && $user_like->dislike_or_like == -1) {
                $user_like->delete();
                $comment->increment('likes');
            } else if ($dislike_or_like == -1 && $user_like->dislike_or_like == 1) {
                $user_like->delete();
                $comment->decrement('likes');
            }
        }
        $user_like = UserLike::where([
            'user_id' => Auth::user()->id,
            'comment_id' => $data->comment_id,
        ])->first();
        $now_comment_like = Comment::find($data->comment_id)->likes;
        $lock->release();
        return response()->json(['success' => '更新喜歡狀態成功', 'user_comment_like' => $user_like?->dislike_or_like, 'now_comment_like' => $now_comment_like], 200);
    }


}