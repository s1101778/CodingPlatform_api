<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Post;
use App\Models\Community;
use App\Models\Tags;
use App\Models\User;
use App\Models\UserLike;
use Illuminate\Support\Facades\Cache;
use voku\helper\HtmlDomParser;

class CommentController extends Controller
{
    public function Comment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'post_id' => 'nullable|exists:posts,id',
            'community_id' => 'nullable|exists:communities,id',
            'comment_id' => 'exists:comments,id',
            'parent_comment_id' => 'exists:comments,id',
            'content' => 'required',
        ], [
            'required' => '欄位沒有填寫完整!',
            'post_id.exists' => '貼文不存在',
            'community_id.exists' => '討論區不存在',
            'comment_id.exists' => 'comment不存在',
            'parent_comment_id.exists' => '父comment不存在',
        ]);

        if (!$data->has('post_id') && !$data->has('community_id')) {
            return response()->json(['error' => '必須提供 post_id 或 community_id'], 422);
        }

        if ($data->has('post_id') && $data->has('community_id')) {
            return response()->json(['error' => '不能同時提供 post_id 和 community_id'], 422);
        }

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $temp_content = $data->content;
        // preg_match_all('/@(\w+)/', $temp_content, $matches);
        // $tags = collect($matches[1]);
        $temp_content = str_replace("data-id", "dataid", $temp_content);
        $tags = collect(HtmlDomParser::str_get_html($temp_content)->findMulti('.mention')->dataid);
        if (Comment::find($data->comment_id)) {
            if (Comment::find($data->comment_id)->user_id == Auth::user()->id) {
                Comment::find($data->comment_id)->update([
                    'content' => $data->content,
                ]);

                Tags::where('comment_id', $data->comment_id)->delete();

                $tags->map(function ($item, $key) use ($data) {
                    $taged_user_id = User::where('account', $item)->first()->id;
                    Tags::create([
                        'comment_user_id' => Auth::user()->id,
                        'Taged_user_id' => $taged_user_id,
                        'post_id' => $data->post_id,
                        'community_id' => $data->community_id,
                        'comment_id' => $data->comment_id,
                    ]);
                });
                return response()->json(['success' => '成功更新留言'], 200);
            } else {
                return response()->json(['error' => '權限不符'], 402);
            }
        } else {
            // 獲取父評論
            if ($data->parent_comment_id) {
                $parent_comment = Comment::find($data->parent_comment_id);
                // 檢查父評論的 post_id 與目前 post_id 是否匹配
                if ($data->has('post_id')) {
					if ((int)$parent_comment->post_id !== (int)$data->post_id) {
						return response()->json(['error' => '影片ID與父Comment不匹配'], 422);
					}
                } else if($data->has('community_id')) {
					if ((int)$parent_comment->community_id !== (int)$data->community_id) {
						return response()->json(['error' => '文章ID與父Comment不匹配'], 422);
					}
                }
                // 建立評論
                $comment = Comment::create([
                    'parent_comment_id' => $data->parent_comment_id,
                    'user_id' => Auth::user()->id,
                    'post_id' => $data->post_id, // 可以是 null
                    'community_id' => $data->community_id,  // 可以是 null
                    'content' => $data->content,
                ]);

                // 增加評論統計（僅在 post_id 時存在）
                if ($data->post_id) {
                    Post::find($data->post_id)->increment('comments_count');
                } else if ($data->community_id) {
                    Community::find($data->community_id)->increment('comments_count');
                }

                // 增加子評論統計
                $parent_comment->increment('children_comment_count');

                // 處理標籤
                $tags->map(function ($item) use ($data, $comment) {
                    $taged_user = User::where('account', $item)->first();
                    if ($taged_user) { // 確定使用者存在
                        Tags::create([
                            'comment_user_id' => Auth::user()->id,
                            'Taged_user_id' => $taged_user->id,
                            'post_id' => $data->post_id, // 可以是 null
                            'community_id' => $data->community_id, // 可以是 null
                            'comment_id' => $comment->id,
                        ]);
                    }
                });

                // 返回成功響應
                $comment = self::tidy_comment(Comment::where('id', $comment->id)->get());
                return response()->json(['success' => '成功發布留言', 'comment' => $comment], 200);
            } else {
                $comment = Comment::create([
                    'user_id' => Auth::user()->id,
                    'post_id' => $data->post_id,
                    'community_id' => $data->community_id,
                    'content' => $data->content,
                ]);

                // 增加評論統計（僅在 post_id 時存在）
                if ($data->post_id) {
                    Post::find($data->post_id)->increment('comments_count');
                } else if ($data->community_id) {
                    Community::find($data->community_id)->increment('comments_count');
                }

                $tags->map(function ($item, $key) use ($data, $comment) {
                    $taged_user_id = User::where('account', $item)->first()->id;
                    Tags::create([
                        'comment_user_id' => Auth::user()->id,
                        'Taged_user_id' => $taged_user_id,
                        'post_id' => $data->post_id,
                        'community_id' => $data->community_id,
                        'comment_id' => $comment->id,
                    ]);
                });
                $comment = self::tidy_comment(Comment::where('id', $comment->id)->get());
                return response()->json(['success' => '成功發布留言', 'comment' => $comment], 200);
            }
        }
    }

    public function del_comment(Request $data) // 刪除留言
    {
        $validator = Validator::make($data->all(), [
            'comment_id' => 'required|exists:comments,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'comment_id.exists' => '留言不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $comment = Comment::where([
            'id' => $data->comment_id,
        ]);
        if (Auth::user()->id != $comment->first()->user_id) {
            return response()->json(['error' => '權限不符'], 403);
        }


        if ($comment->first()->parent_comment_id != null) {     // 子留言刪除
            Comment::find($comment->first()->parent_comment_id)->decrement('children_comment_count');
        } else {    // 父留言刪除後，它底下的子留言沒有被刪除
            $children_comment_count = Comment::where([
                'parent_comment_id' => $data->comment_id,
            ])->count();
        }

        $post_id = $comment->first()->post_id;              // 取得post_id
        $community_id = $comment->first()->community_id;    // 取得community_id

        $deleted = $comment->delete();


        if ($deleted) {
            if ($post_id !== null) {  // 屬於影片留言
                if (isset($children_comment_count)) {
                    Post::find($post_id)->decrement('comments_count', 1 + $children_comment_count);
                } else {
                    Post::find($post_id)->decrement('comments_count');
                }
            } else if ($community_id !== null) {
                if (isset($children_comment_count)) {
                    Community::find($community_id)->decrement('comments_count', 1 + $children_comment_count);
                } else {
                    Community::find($community_id)->decrement('comments_count');
                }
            }
            return response()->json(['success' => '成功刪除留言'], 200);
        }

        return response()->json(['error' => '刪除留言失敗'], 500);
    }


    public function check_is_children_comment(Request $data)
    {
        if ($data->comment_id) {
            $validator = Validator::make($data->all(), [
                'comment_id' => 'exists:comments,id',
            ], [
                'comment_id.exists' => '評論不存在',
            ]);
            if ($validator->fails()) {
                return response()->json(['error' => $validator->errors()->first()], 422);
            }
            if (Comment::find($data->comment_id)->parent_comment_id != null) {
                return response()->json(['success' => true, 'parent_comment_id' => Comment::find($data->comment_id)->parent_comment_id], 200);
            } else {
                return response()->json(['success' => false], 200);
            }
        }
    }

    public function get_comment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'post_id' => 'nullable|exists:posts,id',
            'community_id' => 'nullable|exists:communities,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'post_id.exists' => '貼文不存在',
            'community_id.exists' => '社群不存在',
        ]);

        if (!$data->has('post_id') && !$data->has('community_id')) {
            return response()->json(['error' => '必須提供 post_id 或 community_id'], 422);
        }

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        if ($data->has('post_id')) {
            $post_id = $data->post_id;
            $comments = Post::find($post_id)->Comment->whereNull('parent_comment_id')->sortBy('created_at')->sortByDesc('likes')->values();
        } else if ($data->has('community_id')) {
            $community_id = $data->community_id;
            $comments = Community::find($community_id)->Comment->whereNull('parent_comment_id')->sortBy('created_at')->values();
        }
        $comments = self::tidy_comment($comments);
        $comments = $comments->filter()->values(); //清null
        return response()->json(['success' => $comments], 200);
    }

    public function get_children_comment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'parent_comment_id' => 'required|exists:comments,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'parent_comment_id.exists' => '留言不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        $parent_comment_id = $data->parent_comment_id;
        $children_comments = Comment::where('parent_comment_id', $parent_comment_id)->get()->sortBy('created_at')->values();
        $children_comments = self::tidy_comment($children_comments);
        $children_comments = $children_comments->filter()->values(); //清null
        return response()->json(['children_comments_count' => $children_comments->count(), 'success' => $children_comments], 200);
    }

    public function tidy_comment($comments)
    {
        $comments = $comments->map(function ($item, $key) {
            $mention = collect(json_decode($item['mention'], true));
            $mention_name = collect();
            $mention->map(function ($item, $key) use ($mention_name) {
                $mention_name->push(User::find($item)->name);
            });
            return collect([
                'id' => $item['id'],
                'user_id' => $item['user_id'],
                'post_id' => $item['post_id'],
                'community_id' => $item['community_id'],
                'user_name' => $item->User->name,
                'user_account' => $item->User->account,
                'picture' => $item->User->picture,
                'content' => $item['content'],
                'likes' => $item['likes'],
                'children_comment_count' => $item['children_comment_count'],
                // ->take(3)
                'children_comments' => self::tidy_comment(Comment::where('parent_comment_id', $item['id'])->get()->sortBy('created_at')->values()),
                'mention' => $mention,
                'mention_name' => $mention_name,
                'created_at' => $item['created_at']->format('Y/m/d H:i:s'),
                'updated_at' => $item['updated_at']->format('Y/m/d H:i:s'),
            ]);
        });
        return $comments;
    }





















}



