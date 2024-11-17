<?php

namespace App\Http\Controllers;

use App\Models\UserSubscribe;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Post;
use App\Models\Community;
use App\Models\User;
use Illuminate\Support\Facades\Cache;
use App\Http\Controllers\PostController;
use App\Http\Controllers\CommunityController;

class GetSubscribeController extends Controller
{
    public function get_subscribe(Request $data)
    {
        $user_subscribe_author = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'subscribe_author_id' => $data->author_id
        ])->first()?->subscribe;
		
        return response()->json(['user_subscribe_author' => $user_subscribe_author], 200);
    }
	
	public function get_follow(Request $data)
    {
        $user_follow_author = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'follow_author_id' => $data->author_id
        ])->first()?->follow;
		
        return response()->json(['user_follow_author' => $user_follow_author], 200);
    }

    // 訂閱功能
    public function subscribe_author(Request $data)
    {
        $subscribe = $data->subscribe;
        if ($subscribe != 0 && $subscribe != 1) {
            return response()->json(['error' => 'subscribe 只限於 0 or 1'], 402);
        }
        $user_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'subscribe_author_id' => $data->author_id,
        ])->first();
        $user = User::find($data->author_id);
        if ($user_subscribe === null) {
            if ($subscribe == 1) {
                UserSubscribe::create([
                    'user_id' => Auth::user()->id,
                    'subscribe_author_id' => $data->author_id,
                    'subscribe' => $subscribe,
                ]);
                $user->increment('subscriptions');
            }

        } else {
            if ($subscribe == 0 && $user_subscribe->subscribe == 1) {
                $user_subscribe->delete();
                $user->decrement('subscriptions');
            }
        }
        $user_subscribe = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'subscribe_author_id' => $data->author_id,
        ])->first();

        return response()->json(['success' => '更新收藏狀態成功', 'user_subscribe_author' => $user_subscribe?->subscribe], 200);

    }
	
	public function follow_author(Request $data)
    {
        $follow = $data->follow;
        if ($follow != 0 && $follow != 1) {
            return response()->json(['error' => 'follow 只限於 0 or 1'], 402);
        }
        $user_follow = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'follow_author_id' => $data->author_id,
        ])->first();
        $user = User::find($data->author_id);
        if ($user_follow === null) {
            if ($follow == 1) {
                UserSubscribe::create([
                    'user_id' => Auth::user()->id,
                    'follow_author_id' => $data->author_id,
                    'follow' => $follow,
                ]);
                $user->increment('follows');
            }

        } else {
            if ($follow == 0 && $user_follow->follow == 1) {
                $user_follow->delete();
                $user->decrement('follows');
            }
        }
        $user_follow = UserSubscribe::where([
            'user_id' => Auth::user()->id,
            'follow_author_id' => $data->author_id,
        ])->first();

        return response()->json(['success' => '更新關注狀態成功', 'user_follow_author' => $user_follow?->follow], 200);

    }

    public function get_subscribe_author(Request $data)
    {
        $userSubscribes = Auth::user()->UserSubscribe()->get();

        if ($userSubscribes->isEmpty()) {
            return response()->json(['error' => '尚未訂閱'], 200);
        }

        $users = $userSubscribes->map(function ($subscribe) {
            return $subscribe->AuthorPost; // 返回每個訂閱的作者（User 模型）
        })->filter()->values();
		
        return response()->json(['success' => $users], 200);
    }
	
	public function get_follow_author(Request $data)
    {
        $userFollows = Auth::user()->UserSubscribe()->get();

        if ($userFollows->isEmpty()) {
            return response()->json(['error' => '尚未關注'], 200);
        }

        $users = $userFollows->map(function ($follow) {
            return $follow->AuthorCommunity;
        })->filter()->values();
		
        return response()->json(['success' => $users], 200);
    }
}