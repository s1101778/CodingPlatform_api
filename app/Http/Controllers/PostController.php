<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\UvaTopic;
use App\Models\Post;
use App\Models\PostLimit;
use App\Models\TempPost;
use App\Models\User;
use App\Models\UserLike;
use App\Models\UserSubscribe;
use App\Models\PostView;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;


class PostController extends Controller
{
    public function user_post_check(Request $data)
    {
        return response()->json(['check' => Post::find($data->post_id)->user_id == Auth::user()->id], 200);
    }

    public function post(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'serial' => 'required|exists:uva_topics,serial',
            'video_url' => 'required|active_url',
            'content' => 'required',
        ], [
            'required' => '欄位沒有填寫完整!',
            'video_url.active_url' => '請放入正確的 youtube 影片網址',
            'serial.exists' => '題目編號不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        preg_match('#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#', $data->video_url, $matches);
        if (count($matches) == 0) {
            return response()->json(['error' => '請放入正確的 youtube 影片網址'], 402);
        }
        $video_id = $matches[0];
        $video_pic_url = 'https://img.youtube.com/vi/' . $video_id . '/maxresdefault.jpg';
        $headers = @get_headers($video_pic_url);
        if (!$headers || $headers[0] == 'HTTP/1.1 404 Not Found') {
            $video_pic_url = 'https://img.youtube.com/vi/' . $video_id . '/mqdefault.jpg';
        }

        if (Post::find($data->post_id)) {
            if (Post::find($data->post_id)->user_id == Auth::user()->id) {
                Post::find($data->post_id)->update([
                    'uva_topic_id' => UvaTopic::get_uva_topic_id($data->serial),
                    'video_url' => 'https://www.youtube.com/watch?v=' . $video_id,
                    'video_id' => $video_id,
                    'video_pic_url' => $video_pic_url,
                    'content' => $data->content,
                    'code' => $data->code,
                    'code_type' => $data->code_type,
                    'code_editor_type' => $data->code_editor_type,
                ]);

                $assignment = Auth::user()->UserClass->map->CodingClass->map->Assignment->flatten(1);
                $now = Carbon::now();
                $assignment_update = 0;
                $assignment = $assignment->map(function ($item, $key) use ($now, $data, $video_id, $video_pic_url, &$assignment_update) {
                    if ($now->isAfter($item->start_at) && $now->isBefore($item->end_at)) {
                        if ($item->HandInAssignment?->map->TempPost?->map->post_id->first() == $data->post_id) {
                            TempPost::where(['assignment_id' => $item->id, 'post_id' => $data->post_id])->first()->update([
                                'uva_topic_id' => UvaTopic::get_uva_topic_id($data->serial),
                                'video_url' => 'https://www.youtube.com/watch?v=' . $video_id,
                                'video_id' => $video_pic_url,
                                'video_pic_url' => $video_pic_url,
                                'content' => $data->content,
                                'code' => $data->code,
                                'code_type' => $data->code_type,
                                'code_editor_type' => $data->code_editor_type,
                            ]);
                            $assignment_update = 1;
                        }
                    }
                });
                if ($assignment_update == 1) {
                    return response()->json(['success' => '成功更新影片 並更新在期限內且選擇此影片之作業', 'post_id' => $data->post_id], 200);
                } else {
                    return response()->json(['success' => '成功更新影片', 'post_id' => $data->post_id], 200);
                }
            } else {
                return response()->json(['error' => '此影片並非您發布，請重新輸入'], 200);
            }

        } else {
            $postlimit = Auth::user()->PostLimit->first();
            if ($postlimit) {
                $now = Carbon::now();
                if ($now->isBefore($postlimit->end_at)) {
                    return response()->json(['error' => '一分鐘內僅限發布一則影片'], 402);
                } else {
                    $postlimit->delete();
                }
            }
            $post = Post::create([
                'user_id' => Auth::user()->id,
                'uva_topic_id' => UvaTopic::get_uva_topic_id($data->serial),
                'video_url' => $data->video_url,
                'video_id' => $video_id,
                'video_pic_url' => $video_pic_url,
                'content' => $data->content,
                'code' => $data->code,
                'code_type' => $data->code_type,
                'code_editor_type' => $data->code_editor_type,
            ]);
            PostLimit::create([
                'user_id' => Auth::user()->id,
                'end_at' => Carbon::now()->addMinutes(1)
            ]);
            return response()->json(['success' => '成功創立影片', 'post_id' => $post->id], 200);
        }
    }

    public function del_post(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'post_id' => 'required|exists:posts,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'post_id.exists' => '影片不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        $Post = Post::where([
            'id' => $data->post_id
        ]);
        if (Auth::user()->id != $Post->first()->user_id) {
            return response()->json(['error' => '權限不符'], 200);
        } else {
            $Post->delete();
            return response()->json(['success' => '成功刪除影片'], 200);
        }
    }
    public function like_post(Request $data)
    {
        $lock = Cache::lock('key', 5);
        if (!$lock->get()) {
            return response()->json(['error' => '操作過於頻繁'], 402);
        }
        $validator = Validator::make($data->all(), [
            'post_id' => 'required|exists:posts,id',
            'dislike_or_like' => 'required',
        ], [
            'required' => '欄位沒有填寫完整!',
            'post_id.exists' => '影片不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        $dislike_or_like = $data->dislike_or_like;
        if ($dislike_or_like != 1 && $dislike_or_like != -1) {
            return response()->json(['error' => 'dislike_or_like只限於-1 or 1'], 402);
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

    public function get_like_post(Request $data)
    {
        $user = Auth::user();

        // 取得屬於當前用戶且 dislike_or_like 等於 1 的 UserLike 記錄
        $userLikes = UserLike::where('user_id', $user->id)->get();

        // 檢查是否有喜歡
        if ($userLikes->isEmpty()) {
            return response()->json(['error' => '尚未喜歡'], 200);
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
                return response()->json(['error' => '使用者尚未瀏覽該帳號的影片'], 402);
            }
        }
        $posts = $posts->filter()->values(); //清null
        $posts = $posts->map(
            function ($item, $key) {
                return self::tidy_post($item);
            }
        );
        return response()->json(['success' => $posts], 200);
    }


    // 取得用戶的影片
    public function get_user_post()
    {
        $posts = Auth::user()->Post;
        $posts = $posts->map(
            function ($item, $key) {
                return self::tidy_post($item);
            }
        );
        return response()->json(['success' => $posts], 200);
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
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        $subscribe = $data->subscribe;
        if ($subscribe != 0 && $subscribe != 1) {
            return response()->json(['error' => 'subscribe 只限於 0 or 1'], 402);
        }
        $user_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'author_id' => $data->author_id,
        ])->first();
        $post = Post::find($data->author_id);
        if ($user_subscribe === null) {
            if ($subscribe == 1) {
                UserSubscribe::create([
                    'user_id' => Auth::user()->id,
                    'author_id' => $data->author_id,
                    'subscribe' => $subscribe,
                ]);
                $post->increment('subscribes');
                Auth::user()->increment('subscriptions');
            }

        } else {
            if ($subscribe == 0 && $user_subscribe->subscribe == 1) {
                $user_subscribe->delete();
                $post->decrement('subscribes');
                Auth::user()->decrement('subscriptions');
            }
        }
        $user_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'author_id' => $data->author_id,
        ])->first();

        $now_post_subscribe = Post::find($data->author_id)->subscribes;

        return response()->json(['success' => '更新收藏狀態成功', 'user_post_subscribe' => $user_subscribe?->subscribe, 'now_post_subscribe' => $now_post_subscribe], 200);

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
                return response()->json(['error' => '使用者尚未收藏該帳號的影片'], 402);
            } else {
                return response()->json(['error' => '尚未收藏'], 200);
            }
        }

        // 過濾掉空值並映射處理
        $posts = $posts->filter()->map(function ($item) {
            return self::tidy_post($item);
        });

        return response()->json(['success' => $posts->values()], 200);
    }

    public function get_post_view(Request $data)
    {
        $postView = Auth::user()->PostView;

        if ($postView->isEmpty()) {
            return response()->json(['error' => '尚未瀏覽影片'], 402);
        }
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
                return response()->json(['error' => '使用者尚未瀏覽該帳號的影片'], 402);
            }
        }
        $posts = $posts->filter()->values(); //清null
        $posts = $posts->map(
            function ($item, $key) {
                return self::tidy_post($item);
            }
        );
        return response()->json(['success' => $posts], 200);
    }

    public function get_post_auth(Request $data)
    {
        $post_id = $data->post_id;
        if ($post_id != '') {
            try {
                $post = Post::find($post_id);
                $posts = self::tidy_post($post);
            } catch (\Throwable $th) {
                return response()->json(['success' => '影片不存在'], 402);
            }

            $user_id = Auth::user()->id;
            $postview = PostView::where('user_id', $user_id)->where('post_id', $post_id)->first();

            // 更新或創建訪問記錄
            // if ($postview) {
            //     // 如果記錄存在，更新 visited_at 字段
            //     $postview->update(['visited_at' => now()]);
            // } else {
                PostView::create([
                    'user_id' => $user_id,
                    'post_id' => $post_id,
                    // 'visited_at' => now(),
                ]);
            // }
            $post->increment('views');
        }
        return response()->json(['success' => $posts], 200);
    }

    public function get_post(Request $data)
    {
        $post_id = $data->post_id;
        if ($post_id != '') {
            try {
                $post = Post::find($post_id);
                $posts = self::tidy_post($post);
            } catch (\Throwable $th) {
                return response()->json(['success' => '影片不存在'], 402);
            }
            PostView::create([
                'user_id' => null,
                'post_id' => $post_id,
                //'visited_at' => now(),
            ]);
            $post->increment('views');


        } else {
            $user_account = $data->user_account;
            $serial = $data->serial;
            $star = collect($data->star);
            $code_type = collect($data->code_type);
            $sort = $data->sort;
            $view_sort = $data->view_sort;

            if ($user_account) {
                $user_id = User::where('account', $user_account)->first()->id;
                $posts = Post::where('user_id', $user_id)->get();
                if ($serial) {
                    $posts = $posts->where('uva_topic_id', UvaTopic::firstWhere('serial', $serial)->id);
                }
            } else {
                if ($serial) {
                    $uvaTopic = UvaTopic::where('serial', $serial)->first();
                    if ($uvaTopic) {
                        $posts = Post::where('uva_topic_id', $uvaTopic->id)->get();
                    } else {
                        $posts = collect();
                    }
                } else {
                    $posts = Post::all();
                }
            }
            if (count($star) != 0) {
                $posts = $posts->map(function ($item, $key) use ($star) {
                    if ($star->contains($item->UvaTopic->star)) {
                        return $item;
                    }
                });
            }
            if (count($code_type) != 0) {
                $code_type = $code_type->map(function ($item, $key) {
                    switch ($item) {
                        case '14':
                            return 'C';
                            break;
                        case '15':
                            return 'C++';
                            break;
                        case '16':
                            return 'Java';
                            break;
                        case '17':
                            return 'Python';
                            break;
                    }
                });
                $posts = $posts->filter()->values();  //清null 以防上方篩star 出現null 導致$item->code_type 出錯
                $posts = $posts->map(function ($item, $key) use ($code_type) {
                    if ($code_type->contains($item->code_type)) {
                        return $item;
                    }
                });
            }
            switch ($sort) {
                case 0:
                    $posts = $posts->sortByDesc('created_at');
                    break;
                case 1:
                    $posts = $posts->sortBy('created_at');
                    break;
                case 2:
                    $posts = $posts->sortByDesc('created_at')->sortByDesc('likes');
                    break;
                case 3:
                    $posts = $posts->sortByDesc('created_at')->sortBy('likes');
                    break;
                case 4:
                    $posts = $posts->sortByDesc('created_at')->sortByDesc('comments_count');
                    break;
                case 5:
                    $posts = $posts->sortByDesc('created_at')->sortBy('comments_count');
                    break;
                default:
                    $posts = $posts->sortByDesc('created_at');
                    break;
            }
            if($view_sort){
                $posts = $posts->sortByDesc('views');
            }
            $posts = $posts->filter()->values(); //清null
            $posts = $posts->map(
                function ($item, $key) {
                    return self::tidy_post($item);
                }
            );
        }
        return response()->json(['success' => $posts], 200);
    }

    public function get_temp_post(Request $data)
    {
        $temp_post_id = $data->temp_post_id;
        $validator = Validator::make($data->all(), [
            'temp_post_id' => 'required|exists:temp_posts,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'temp_post_id.exists' => 'temp影片不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }

        $temp_post = TempPost::find($temp_post_id);
        $temp_post->user_account = $temp_post->fresh()->User->account;
        $temp_post->user_name = $temp_post->fresh()->User->name;
        $temp_post->user_picture = $temp_post->fresh()->User->picture;
        $temp_post->uva_topic = $temp_post->UvaTopic;
        return response()->json(['success' => $temp_post], 200);
    }

    public function tidy_post($item)
    {
        return collect([
            'id' => $item['id'],
            'user_id' => $item['user_id'],
            'user_account' => $item->User->account,
            'user_name' => $item->User->name,
            'user_picture' => $item->User->picture,
            'uva_topic' => $item->UvaTopic,
            'video_url' => $item['video_url'],
            'video_id' => $item['video_id'],
            'video_pic_url' => $item['video_pic_url'],
            'content' => $item['content'],
            'likes' => $item['likes'],
            'subscribes' => $item['subscribes'],
            'views' => $item['views'],
            'comments_count' => $item['comments_count'],
            'code' => $item['code'],
            'code_editor_type' => $item['code_editor_type'],
            'code_type' => $item['code_type'],
            'created_at' => $item['created_at']->format('Y/m/d H:i:s'),
            'updated_at' => $item['updated_at']->format('Y/m/d H:i:s'),
        ]);
    }
}
