<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\Community;
use App\Models\Note;

class SearchController extends Controller
{
    public function search_community(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'query' => 'required|string|max:255',
        ], [
            'query.required' => '查詢字段是必需的。',
            'query.string' => '查詢字段必須是字符串。',
            'query.max' => '查詢字段不能超過 255 字符。',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        $query = $data->input('query');

        // 查詢資料庫獲取建議
        $search_community = Community::where(function ($q) use ($query) {
            $q->where('title', 'LIKE', "%{$query}%");
                // ->orWhere('content', 'LIKE', "%{$query}%");
        })
			// ->select('id','title','content')
            ->select('id','title') // 獲取相關的列
            ->distinct() // 去除重複結果
            ->limit(5) // 限制為最相關的 5 條
            ->get(); // 獲取結果

        return response()->json($search_community);
    }

    public function search_note(Request $data)
    {
        
        $validator = Validator::make($data->all(), [
            'query' => 'required|string|max:255',
        ], [
            'query.required' => '查詢字段是必需的。',
            'query.string' => '查詢字段必須是字符串。',
            'query.max' => '查詢字段不能超過 255 字符。',
        ]);

        
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 422);
        }

        
        $query = $data->input('query');


        $search_note = Note::where('user_id', Auth::user()->id)
            ->where('title', 'LIKE', "%{$query}%")
            ->select('id', 'title')
            ->distinct()
            ->limit(5)
            ->get();



        return response()->json($search_note);
    }

}