<?php

namespace App\Http\Controllers\Class;

use App\Http\Controllers\Controller;
use App\Models\Assignment;
use App\Models\CodingClass;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Models\HandInAssignment;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\File;

class AssignmentController extends Controller
{
    public function upload_file(Request $data)
    {
        $assignment = Assignment::find($data->assignment_id);

        if ($assignment->getTeacherClass_Teacher_user_id() != Auth::user()->id) {
            return response()->json(['error' => '權限不符，並非課程教授'], 402);
        }

        $file = $data->file('file');

        $filename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $extension = $file->getClientOriginalExtension();

        $final_file = $filename . '.' . $extension;

        $directory = public_path('uploads/assignment/' . $data->assignment_id);

        if (!file_exists($directory)) {
            mkdir($directory, 0755, true);
            chown($directory, 'www-data');
        }

        $file_path = $directory . '/' . $final_file;
        if (file_exists($file_path)) {
            return response()->json(['error' => '檔案已存在，請更改檔名後再上傳'], 409);
        }

        $file->move($directory, $final_file);

        return response()->json(['message' => 'success add'], 200);
    }
    public function delete_file(Request $data)
    {
        $assignment = Assignment::find($data->assignment_id);

        if ($assignment->getTeacherClass_Teacher_user_id() != Auth::user()->id) {
            return response()->json(['error' => '權限不符，並非課程教授'], 402);
        }

        $files = scandir(public_path('uploads/assignment/' . $data->assignment_id));
        $file_count = count($files) - 2;
        foreach ($files as $file) {
            if (strpos($file, $data->file_name) === 0) {
                unlink(public_path('uploads/assignment/' . $data->assignment_id) . DIRECTORY_SEPARATOR . $file);
            }
        }
        if ($file_count - 1 == 0) {
            rmdir(public_path('uploads/assignment/' . $data->assignment_id));
        }

        return response()->json(['success' => 'success delete', 'test' => $file_count], 200);
    }
    public function get_assignment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'coding_class_id' => 'required|exists:coding_classes,id',
            'assignment_id' => 'exists:assignments,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'coding_class_id.exists' => '課程不存在',
            'assignment_id.exists' => '作業不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        $codingclass = CodingClass::find($data->coding_class_id);
        if (
            $codingclass->getTeacherClass_Teacher_user_id() != Auth::user()->id &&
            !$codingclass->getTeacherClass_TA_user_ids()->contains(Auth::user()->id) &&
            !$codingclass->getUserClass_user_ids()->contains(Auth::user()->id)
        ) {
            return response()->json(['error' => '權限不符，並非此課程教授、TA、學生'], 402);
        }

        $assignment = $codingclass->Assignment;
        $now = Carbon::now();

        if ($data->assignment_id) {
            $assignment = $assignment->where('id', $data->assignment_id)->first();
            if (!$assignment) {
                return response()->json(['error' => '此作業並非此課程'], 402);
            }

            $assignment->hand_in_assignment_id = Auth::user()->HandInAssignment->firstWhere('assignment_id', $data->assignment_id)?->id;
            $assignment->temp_post_id = Auth::user()->HandInAssignment->firstWhere('assignment_id', $data->assignment_id)?->TempPost?->id;
            $assignment->in_time = $now->isAfter($assignment->start_at) && $now->isBefore($assignment->end_at);
        } else {
            $assignment->map(function ($item, $key) use ($now, $codingclass) {
                if (Auth::user()->isadmin > 0) {
                    $item->hand_in_count = $item->fresh()->HandInAssignment->count() . '/' . $codingclass->getUserClass_user_ids()->count();
                }
                $item->hand_in_assignment_id = Auth::user()->HandInAssignment->firstWhere('assignment_id', $item->id)?->id;
                $item->temp_post_id = Auth::user()->HandInAssignment->firstWhere('assignment_id', $item->id)?->TempPost?->id;

                $item->in_time = $now->isAfter($item->start_at) && $now->isBefore($item->end_at);
                return $item;
            });
        }
        return response()->json(['success' => $assignment], 200);
    }

    public function assignment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'coding_class_id' => 'required|exists:coding_classes,id',
            'name' => 'required',
            'start_at' => 'required|date_format:Y-m-d H:i:s',
            'end_at' => 'required|date_format:Y-m-d H:i:s|after:start_at',
        ], [
            'required' => '欄位沒有填寫完整!',
            'coding_class_id.exists' => '課程不存在',
            'date_format' => '開始或結束時間格式錯誤(Y-m-d H:i:s)',
            'after' => '結束日應遠於開始日',
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()->first()], 402);
        }

        if(CodingClass::find($data->coding_class_id)->getTeacherClass_Teacher_user_id()!=Auth::user()->id){
            return response()->json(['error' => '權限不符，並非此課程教授'], 402);
        }
        if($data->assignment_id){
            $type = Assignment::find($data->assignment_id)->type;
        }
        $match = ['id' => $data->assignment_id];
        $assignment = Assignment::updateOrCreate($match, [
            'coding_class_id' => $data->coding_class_id,
            'type' => $data->assignment_id ? $type : $data->type,
            'name' => $data->name,
            'content'=>$data->content,
            'start_at' => $data->start_at,
            'end_at' => $data->end_at,
            'file' => $data->file,
        ]);
        if($assignment->wasRecentlyCreated){
            return response()->json(['success' => '成功發布作業', 'assignment_id' => $assignment->id], 200);
        }else{
            return response()->json(['success' => '成功更新作業'], 200);
        }
    }












    public function del_assignment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'assignment_id' => 'required|exists:assignments,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'assignment_id.exists' => '作業不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        if(Assignment::find($data->assignment_id)->getTeacherClass_Teacher_user_id()!=Auth::user()->id){
            return response()->json(['error' => '權限不符，並非此課程教授'], 402);
        }

        $assignment = Assignment::find($data->assignment_id);

        File::deleteDirectory('uploads/assignment/' . $data->assignment_id);
        Assignment::find($data->assignment_id)->delete();
        return response()->json(['success' => '成功刪除作業'], 200);
    }
}
