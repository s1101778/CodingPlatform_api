<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Community;

class SearchController extends Controller
{
    public function suggestions(Request $data)
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

        // 查詢資料庫獲取建議，包含 title 和 content
        $suggestions = Community::where(function ($q) use ($query) {
            $q->where('title', 'LIKE', "%{$query}%")
                ->orWhere('content', 'LIKE', "%{$query}%");
        })
            ->select('title', 'content') // 獲取相關的列
            ->distinct() // 去除重複結果
            ->limit(5) // 限制為最相關的 5 條
            ->get(); // 獲取結果

        return response()->json($suggestions);
    }
}