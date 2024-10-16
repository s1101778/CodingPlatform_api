<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Community;
use App\Models\PostLimit;
use App\Models\User;
//use App\Models\UserLike;
//use App\Models\UserSubscribe;
//use App\Models\PostView;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;

/**
 * @OA\Post(
 *      path="/forum/community",
 *      operationId="manageCommunityPost",
 *      tags={"Community"},
 *      summary="Create or update a community post",
 *      description="Create a new community post or update an existing one",
 *      @OA\RequestBody(
 *          required=true,
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="community_id",
 *                  type="integer",
 *                  description="Community post ID, required for updating"
 *              ),
 *              @OA\Property(
 *                  property="title",
 *                  type="string",
 *                  description="Title of the community post"
 *              ),
 *              @OA\Property(
 *                  property="content",
 *                  type="string",
 *                  description="Content of the community post"
 *              )
 *          )
 *      ),
 *      @OA\Response(
 *          response=200,
 *          description="Successful operation",
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="success",
 *                  type="string",
 *                  description="Success message"
 *              ),
 *              @OA\Property(
 *                  property="community_id",
 *                  type="integer",
 *                  description="ID of the community post"
 *              )
 *          )
 *      ),
 *      @OA\Response(
 *          response=422,
 *          description="Validation error",
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="error",
 *                  type="string",
 *                  description="Error message"
 *              )
 *          )
 *      ),
 *      @OA\Response(
 *          response=403,
 *          description="Forbidden - Not the post owner",
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="error",
 *                  type="string",
 *                  description="Error message"
 *              )
 *          )
 *      ),
 *      @OA\Response(
 *          response=429,
 *          description="Too Many Requests - Post limit reached",
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="error",
 *                  type="string",
 *                  description="Error message"
 *              )
 *          )
 *      ),
 *      security={
 *          {"bearerAuth": {}}
 *      }
 * )
 */

class CommunityController extends Controller
{
    public function community(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'title' => 'required',
            'content' => 'required',
        ], [
            'required' => '欄位沒有填寫完整!',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        if (Community::find($data->community_id)) {   // 更新討論區的貼文
            if (Community::find($data->community_id)->user_id == Auth::user()->id) {
                Community::find($data->community_id)->update([
                    'title' => $data->title,
                    'content' => $data->content,
                ]);
                return response()->json(['success' => '成功更新貼文', 'community_id' => $data->community_id], 200);
            } else {
                return response()->json(['error' => '此貼文並非您發布，請重新輸入'], 403);
            }
        } else {  // 創建討論區貼文
            $postlimit = PostLimit::where('user_id', Auth::id())
                ->where('type', 'community')
                ->first();

            if ($postlimit) {
                $now = Carbon::now();
                if ($now->isBefore($postlimit->end_at)) {
                    return response()->json(['error' => '一分鐘內僅限發布一則貼文'], 429);
                } else {
                    $postlimit->delete();
                }
            }
            $community = Community::create([
                'user_id' => Auth::user()->id,
                'title' => $data->title,
                'content' => $data->content,
            ]);
            PostLimit::create([
                'user_id' => Auth::user()->id,
                'end_at' => Carbon::now()->addMinutes(1),
                'type' => 'community',
            ]);
            return response()->json(['success' => '成功創立貼文', 'community_id' => $community->id], 200);
        }
    }

    public function del_community(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'community_id' => 'required|exists:communities,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'community_id.exists' => '貼文不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        $community = Community::where([
            'id' => $data->community_id
        ]);
        if (Auth::user()->id != $community->first()->user_id) {
            return response()->json(['error' => '權限不符'], 403);
        } else {
            $community->delete();
            return response()->json(['success' => '成功刪除貼文'], 200);
        }
    }

    // 取得用戶的討論
    public function get_user_community()
    {
        $communities = Auth::user()->Community;
        $communities = $communities->map(
            function ($item, $key) {
                return self::tidy_community($item);
            }
        );
        return response()->json(['success' => $communities], 200);
    }

    public function get_all_community()
    {
        $communities = Community::with('user:id,cover,picture') // 预加载用户信息
            ->select('id', 'title', 'user_id') // 选择需要的社区字段
            ->get()
            ->map(function ($community) {
                return [
                    'id' => $community->id,
                    'title' => $community->title,
                    'cover' => $community->user->cover,
                    'picture' => $community->user->picture,
                ];
            });
        

        return response()->json(['success' => $communities], 200);
    }


    public function get_community(Request $data)
    {
        $community_id = $data->community_id;
        if ($community_id != '') {
            try {
                $communities = Community::find($community_id);
                $communities = self::tidy_community($communities);
            } catch (\Throwable $th) {
                return response()->json(['error' => '影片不存在'], 404);
            }
        } else {
            $user_account = $data->user_account;
            $sort = $data->sort;
            // $view_sort = $data->view_sort;

            if ($user_account) {
                $user_id = User::where('account', $user_account)->first()->id;
                $communities = Community::where('user_id', $user_id)->get();
            } else {
                $communities = Community::all();
            }
            switch ($sort) {
                case 0:
                    $communities = $communities->sortByDesc('created_at');
                    break;
                case 1:
                    $communities = $communities->sortBy('created_at');
                    break;
                case 2:
                    $communities = $communities->sortByDesc('created_at')->sortByDesc('comments_count');
                    break;
                case 3:
                    $communities = $communities->sortByDesc('created_at')->sortBy('comments_count');
                    break;
                default:
                    $communities = $communities->sortByDesc('created_at');
                    break;
            }
            // if($view_sort){
            //     $communities = $communities->sortByDesc('views');
            // }
            $communities = $communities->filter()->values(); //清null
            $communities = $communities->map(
                function ($item, $key) {
                    return self::tidy_community($item);
                }
            );
        }
        return response()->json(['success' => $communities], 200);
    }













    public function tidy_community($item)
    {
        return collect([
            'id' => $item['id'],
            'user_id' => $item['user_id'],
            'user_account' => $item->User->account,
            'user_name' => $item->User->name,
            'user_picture' => $item->User->picture,
            'title' => $item['title'],
            'content' => $item['content'],
            // 'likes' => $item['likes'],
            // 'views' => $item['views'],
            'comments_count' => $item['comments_count'],
            'created_at' => $item['created_at']->format('Y/m/d H:i:s'),
            'updated_at' => $item['updated_at']->format('Y/m/d H:i:s'),
        ]);
    }

}
