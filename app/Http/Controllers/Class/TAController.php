<?php

namespace App\Http\Controllers\Class;

use App\Http\Controllers\Controller;
use App\Models\CodingClass;
use App\Models\TeacherClass;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

class TAController extends Controller
{
    public function get_TA_class(Request $data){
        $validator = Validator::make($data->all(), [
            'coding_class_id' => 'exists:coding_classes,id',
        ], [
            'coding_class_id.exists' => '課程不存在',
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()->first(), 402]);
        }
        if($data->coding_class_id){
            $codingclass = CodingClass::find($data->coding_class_id);
            if(!$codingclass->getTeacherClass_TA_user_ids()->contains(Auth::user()->id)){
                return response()->json(['error' => '權限不符，並非此課程TA'], 402);
            }
            $TeacherClass = $codingclass->fresh();
            $TeacherClass->TA_user_ids = $codingclass->getTeacherClass_TA_user_ids();
            $TeacherClass->user = $codingclass->UserClass->pluck('User')->map->only(['id', 'name', 'account']);
        }else{
            $TeacherClass = Auth::user()->TeacherClass->map(function ($item, $key) {
                $item = $item->CodingClass;
                $codingclass = CodingClass::find($item->id);

                $item->teacher = $codingclass->TeacherClass_Teacher->first()->User->only(['id', 'name', 'account']);
                $item->TA_user_ids = $codingclass->getTeacherClass_TA_user_ids();

                $item->user = $codingclass->UserClass->pluck('User')->map->only(['id', 'name', 'account']);

                return $item;
            });
        }
        return response()->json(['success' => $TeacherClass], 200);
    }
}
