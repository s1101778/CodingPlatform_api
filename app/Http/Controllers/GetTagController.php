<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Tags;
use App\Models\UserLike;

class GetTagController extends Controller
{
    public function get_tags()
    {
        $tagscount = 0;

        $tags = Auth::user()->Taged->map(function ($item, $key) use (&$tagscount) {
            if ($item['viewed'] == 0) {
                $tagscount++;
            }
            return collect([
                'id' => $item['id'],
                'comment_user_id' => $item['comment_user_id'],
                'comment_user_name' => $item->Comment_User->name,
                'comment_user_picture' => $item->Comment_User->picture,
                'post_id' => $item['post_id'] ?? '',
                'post_uva_show' => $item->Post->UvaTopic->show ?? '',
                'post_user_name' => $item->Post->User->name ?? '',
                'community_id' => $item['community_id'] ?? '',
                'community_title' => $item->Community->title ?? '',
                'community_user_name' => $item->Community->User->name ?? '',
                'comment_id' => $item['comment_id'],
                'viewed' => $item['viewed'],
                'created_at' => $item['created_at']->format('Y/m/d H:i:s'),
                'updated_at' => $item['updated_at']->format('Y/m/d H:i:s'),
            ]);
        });
        $tags =$tags->sortByDesc('created_at');
        $tags = $tags->filter()->values();
        return response()->json(['count' => $tagscount, 'success' => $tags], 200);
    }
    public function tag_viewed(Request $data)
    {
        Tags::find($data->tag_id)->update(['viewed' => 1]);
        return response()->json(['success'=> 'success'],200);
    }
    public function all_tag_view()
    {
        Auth::user()->Taged->map(function ($item, $key) {
            Tags::find($item['id'])->update(['viewed' => 1]);
        });
        return response()->json(['success' => 'success'], 200);
    }
}
