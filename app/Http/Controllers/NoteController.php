<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Note;
use App\Models\User;


class NoteController extends Controller
{
    public function note(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'title' => 'required|max:20',
            'content' => 'required',
        ], [
            'required' => '欄位沒有填寫完整!',
			'title.max' => '標題不得超過20字!',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        if (Note::find($data->note_id)) {   // 更新討論區的貼文
            if (Note::find($data->note_id)->user_id == Auth::user()->id) {
                Note::find($data->note_id)->update([
                    'title' => $data->title,
                    'content' => $data->content,
                ]);
                return response()->json(['success' => '成功更新貼文', 'note_id' => $data->note_id], 200);
            } else {
                return response()->json(['error' => '此貼文並非您發布，請重新輸入'], 403);
            }
        } else {  // 創建討論區貼文
            $note = Note::create([
                'user_id' => Auth::user()->id,
                'title' => $data->title,
                'content' => $data->content,
            ]);
            return response()->json(['success' => '成功創立筆記', 'note_id' => $note->id], 200);
        }
    }

    public function del_note(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'note_id' => 'required|exists:notes,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'note_id.exists' => '貼文不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }
        $note = Note::where([
            'id' => $data->note_id
        ]);
        if (Auth::user()->id != $note->first()->user_id) {
            return response()->json(['error' => '權限不符'], 403);
        } else {
            $note->delete();
            return response()->json(['success' => '成功刪除筆記'], 200);
        }
    }

    

    public function get_note(Request $data)
    {
        $notes = Auth::user()->Note()->get()->sortByDesc('created_at');
        $notes = $notes->map(function ($item) {
            return self::tidy_note($item);
        });
		
        return response()->json(['success' => $notes], 200);
    }

    public function tidy_note($item)
    {
        return collect([
            'id' => $item['id'],
            'user_id' => $item['user_id'],
            'title' => $item['title'],
            'content' => $item['content'],
            'created_at' => $item['created_at']->format('Y/m/d H:i:s'),
            'updated_at' => $item['updated_at']->format('Y/m/d H:i:s'),
        ]);
    }
}
