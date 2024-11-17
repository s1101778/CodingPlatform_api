<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Post;
use App\Models\Community;
use App\Models\User;
use App\Models\UserLike;
use Illuminate\Support\Facades\Cache;
use App\Http\Controllers\PostController;
use App\Http\Controllers\CommunityController;


class GetLikeController extends Controller
{
    // 顯示使用者影片的整體喜歡情況以及針對每個留言的喜歡情況
    public function get_like(Request $data)
    {
		// 先執行手動檢查以確保邏輯一致
		if (($data->has('post_id') && $data->has('community_id')) || (!$data->has('post_id') && !$data->has('community_id'))) {
			return response()->json(['error' => '必須提供 post_id 或 community_id，不能兩者皆空或同時提供。'], 422);
		}
		
        $validator = Validator::make($data->all(), [
			'post_id' => 'exists:posts,id',
			'community_id' => 'exists:communities,id',
		], [
			'post_id.exists' => '影片不存在',
			'community_id.exists' => '討論區不存在',
		]);
		
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $user_comment_like = null;

       if ($data->has('post_id')) {
            // 如果提供了 post_id，查詢該 post 的喜歡/不喜歡
            $user_post_like = UserLike::where([
                'user_id' => Auth::user()->id,
                'post_id' => $data->post_id
            ])->whereNull('comment_id')->first()?->dislike_or_like;

            $user_comment_like = UserLike::where([
                'user_id' => Auth::user()->id,
                'post_id' => $data->post_id
            ])->whereNotNull('comment_id')->get();
			
			return response()->json([
				'user_post_like' => $user_post_like,
				'user_comment_like' => $user_comment_like,
			], 200);
        }

        if ($data->has('community_id')) {
            // 如果提供了 community_id，查詢該 community 的喜歡/不喜歡
            // 假設這邊是用 community_id 查詢，邏輯可能根據你的資料結構來調整
            // 這裡假設 UserLike 表有 community_id 欄位
            $user_community_like = UserLike::where([
                'user_id' => Auth::user()->id,
                'community_id' => $data->community_id
            ])->whereNull('comment_id')->first()?->dislike_or_like;

            $user_comment_like = UserLike::where([
                'user_id' => Auth::user()->id,
                'community_id' => $data->community_id
            ])->whereNotNull('comment_id')->get();
			
			return response()->json([
				'user_community_like' => $user_community_like,
				'user_comment_like' => $user_comment_like,
			], 200);
        }
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
	
	public function like_community(Request $data)
    {
        $lock = Cache::lock('key_community', 5);
        if (!$lock->get()) {
            return response()->json(['error' => '操作過於頻繁'], 429);
        }
        $validator = Validator::make($data->all(), [
            'community_id' => 'required|exists:communities,id',
            'dislike_or_like' => 'required',
        ], [
            'required' => '欄位沒有填寫完整!',
            'community_id.exists' => '影片不存在',
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
            'community_id' => $data->community_id,
        ])->whereNull('comment_id')->first();

        $community = Community::find($data->community_id);

        if ($user_like == null) {
            UserLike::create([
                'user_id' => Auth::user()->id,
                'community_id' => $data->community_id,
                'dislike_or_like' => $dislike_or_like,
            ]);
            if ($dislike_or_like == 1) {
                $community->increment('likes');
            } else if ($dislike_or_like == -1) {
                $community->decrement('likes');
            }
        } else {
            if ($dislike_or_like == 1 && $user_like->dislike_or_like == -1) {
                $user_like->delete();
                $community->increment('likes');
            } else if ($dislike_or_like == -1 && $user_like->dislike_or_like == 1) {
                $user_like->delete();
                $community->decrement('likes');
            }
        }
        $user_like = UserLike::where([
            'user_id' => Auth::user()->id,
            'community_id' => $data->community_id,
        ])->whereNull('comment_id')->first();

        $now_community_like = Community::find($data->community_id)->likes;
        $lock->release();

        return response()->json(['success' => '更新喜歡狀態成功', 'user_community_like' => $user_like?->dislike_or_like, 'now_community_like' => $now_community_like], 200);
    }

    // 取得目前使用者喜歡的影片，並根據指定的使用者帳號過濾結果，最後傳回符合條件的影片數據
    public function get_like_post(Request $data)
    {
        $user = Auth::user();

        // 取得屬於當前用戶且 dislike_or_like 等於 1 的 UserLike 記錄
        $userLikes = UserLike::where(['user_id' => $user->id, 'dislike_or_like' => 1])->whereNull('comment_id')->get();

        // 檢查是否有喜歡
        if ($userLikes->isEmpty()) {
            return response()->json(['error' => '尚未喜歡'], 404);
        }

        // 提取喜歡的影片
        $posts = $userLikes->pluck('post');

        $user_id = $data->author_id;

        if($user_id) {
			$posts = $posts->where('user_id', $user_id);
			
			if ($posts->isEmpty()) {
                return response()->json(['error' => '使用者尚未喜歡過該帳號的任何影片'], 402);
            }
		}
		
        $posts = $posts->filter()->unique('id')->values(); // 清除null並移除重複的post_id
		
        $posts = $posts->map(
            function ($item, $key) {
                $postController = new PostController();
                return $postController->tidy_post($item);
            }
        );
        return response()->json(['success' => $posts], 200);
    }

	public function get_like_community(Request $data)
    {
        $user = Auth::user();

        // 取得屬於當前用戶且 dislike_or_like 等於 1 的 UserLike 記錄
        $userLikes = UserLike::where(['user_id' => $user->id, 'dislike_or_like' => 1])->whereNull('comment_id')->get();

        // 檢查是否有喜歡
        if ($userLikes->isEmpty()) {
            return response()->json(['error' => '尚未喜歡'], 404);
        }

        // 提取喜歡的討論
        $communities = $userLikes->pluck('community');

        $user_id = $data->author_id;

        if($user_id) {
			$$communities = $communities->where('user_id', $user_id);
			
			if ($communities->isEmpty()) {
                return response()->json(['error' => '使用者尚未喜歡過該帳號的任何文章'], 402);
            }
		}
        
        $communities = $communities->filter()->unique('id')->values(); //清null並移除重複的community_id
		
        $communities = $communities->map(
            function ($item, $key) {
                $communityController = new CommunityController();
                return $communityController->tidy_community($item);
            }
        );
        return response()->json(['success' => $communities], 200);
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
            if ($comment->post_id !== null) {
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
            }
            if ($comment->community_id !== null) {
                UserLike::create([
                    'user_id' => Auth::user()->id,
                    'community_id' => $comment->community_id,
                    'comment_id' => $data->comment_id,
                    'dislike_or_like' => $dislike_or_like,
                ]);
                if ($dislike_or_like == 1) {
                    $comment->increment('likes');
                } else if ($dislike_or_like == -1) {
                    $comment->decrement('likes');
                }
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