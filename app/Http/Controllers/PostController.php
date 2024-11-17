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
use App\Models\Tags;
use App\Models\UserLike;
use App\Models\UserSubscribe;
use App\Models\PostView;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;

/**
 * @OA\Post(
 *      path="/forum/post",
 *      operationId="postVideo",
 *      tags={"Post"},
 *      summary="Post a video",
 *      description="Post a video with the given details",
 *      @OA\RequestBody(
 *          required=true,
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="serial",
 *                  type="string",
 *                  description="serial"
 *              ),
 *              @OA\Property(
 *                  property="video_url",
 *                  type="string",
 *                  description="Youtube video url"
 *              ),
 *              @OA\Property(
 *                  property="content",
 *                  type="string",
 *                  description="Video content"
 *              ),
 *          )
 *      ),
 *      @OA\Response(
 *          response=200,
 *          description="Successful post video",
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="id",
 *                  type="integer",
 *                  description="Post ID"
 *              ),
 *          )
 *      ),
 *      security={
 *          {"bearerAuth": {}}
 *      }
 * )
 * */
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
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        preg_match('#(?<=v=)[a-zA-Z0-9-]+(?=&)|(?<=v\/)[^&\n]+(?=\?)|(?<=v=)[^&\n]+|(?<=youtu.be/)[^&\n]+#', $data->video_url, $matches);
        if (count($matches) == 0) {
            return response()->json(['error' => '請放入正確的 youtube 影片網址'], 422);
        }
        $video_id = $matches[0];
        $video_pic_url = 'https://img.youtube.com/vi/' . $video_id . '/maxresdefault.jpg';
        $headers = @get_headers($video_pic_url);
        if (!$headers || $headers[0] == 'HTTP/1.1 404 Not Found') {
            $video_pic_url = 'https://img.youtube.com/vi/' . $video_id . '/mqdefault.jpg';
        }
        if (Post::find($data->post_id)) {   // 更新影片
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
                // 取得目前登入使用者（透過Auth::user()）所在的多個班級（UserClass）中的所有作業
                $assignment = Auth::user()->UserClass->map->CodingClass->map->Assignment->flatten(1);
                $now = Carbon::now();   // 取得當前時間
                $assignment_update = 0; // 追蹤是否有作業被更新

                // 處理使用者提交的作業時間，檢查作業的時間範圍，並根據提交的資訊更新對應的TempPost記錄
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
                return response()->json(['error' => '此影片並非您發布，請重新輸入'], 403);
            }
        } else {  // 新增影片
            $postlimit = Auth::user()->PostLimit->first();
            if ($postlimit) {
                $now = Carbon::now();
                if ($postlimit->type === 'post') {
                    if ($now->isBefore($postlimit->end_at)) {
                        return response()->json(['error' => '一分鐘內僅限發布一則影片'], 429);
                    } else {
                        $postlimit->delete();
                    }
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
                'end_at' => Carbon::now()->addMinutes(1),
                'type' => 'post',
            ]);
			
			$subscriptions = UserSubscribe::where('subscribe_author_id', Auth::user()->id)->get();
			
			if ($subscriptions->isNotEmpty())
			{
				foreach ($subscriptions as $subscription) {
					Tags::create([
						'comment_user_id' => Auth::user()->id,
						'Taged_user_id' => $subscription->user_id,
						'post_id' => $post->id,
						'comment_id' => null,
					]);
				}
			}
			
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
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        $post = Post::where([
            'id' => $data->post_id
        ]);
        if (Auth::user()->id != $post->first()->user_id) {
            return response()->json(['error' => '權限不符'], 403);
        } else {
            $post->delete();
            return response()->json(['success' => '成功刪除影片'], 200);
        }
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

    public function get_post(Request $data)
    {
        $post_id = $data->post_id;
        if ($post_id != '') {
            try {
                $post = Post::find($post_id);
				$post->increment('views');
                $posts = self::tidy_post($post);
            } catch (\Throwable $th) {
                return response()->json(['success' => '影片不存在'], 404);
            }
			
            $user_id = $data->user_id;
			$postview = PostView::where('user_id', $user_id)->where('post_id', $post_id)->first();

            // 更新或創建訪問記錄
            if ($postview) {
                // 如果記錄存在，則更新
                $postview->touch();
            } else {
				if($user_id) {
					PostView::create([
						'user_id' => $user_id,
						'post_id' => $post_id,
					]);
				}
            }
        } else {
            $user_account = $data->user_account;
            $serial = $data->serial;
            $star = collect($data->star);
            $code_type = collect($data->code_type);
            $sort = $data->sort;

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
                        case '16':
                            return 'C';
                            break;
                        case '17':
                            return 'C++';
                            break;
                        case '18':
                            return 'Java';
                            break;
                        case '19':
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
				case 6:
                    $posts = $posts->sortByDesc('created_at')->sortByDesc('views');
                    break;
				case 7:
                    $posts = $posts->sortByDesc('created_at')->sortBy('views');
                    break;
                default:
                    $posts = $posts->sortByDesc('created_at');
                    break;
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

    public function get_temp_post(Request $data)    // 返回影片相關資訊
    {
        $temp_post_id = $data->temp_post_id;
        $validator = Validator::make($data->all(), [
            'temp_post_id' => 'required|exists:temp_posts,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'temp_post_id.exists' => 'temp影片不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
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
            //'subscribes' => $item['subscribes'],
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
