<?php

namespace App\Http\Controllers\Class;

use App\Models\Assignment;
use App\Models\CodingClass;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use App\Models\HandInAssignment;
use App\Models\Post;
use App\Models\TempPost;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;

class HandInAssignmentController extends Controller
{
    public function ouput_file(Request $data)
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
        $assignment = Assignment::find($data->assignment_id);
        if (
            $assignment->getTeacherClass_Teacher_user_id() != Auth::user()->id &&
            !$assignment->getTeacherClass_TA_user_ids()->contains(Auth::user()->id)
        ) {
            return response()->json(['error' => '權限不符，並非此課程教授、TA'], 402);
        }
        $class_name = $assignment->CodingClass->name;
        $assignment_name = $assignment->name;

        $zip_file = $class_name . '_' . $assignment_name . '.zip';
        $zip = new \ZipArchive();
        $zip->open($zip_file, \ZipArchive::CREATE | \ZipArchive::OVERWRITE);

        $path = public_path('uploads/assignment/' . $data->assignment_id);
        $files = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($path));
        foreach ($files as $name => $file) {
            if (!$file->isDir()) {
                $filePath = $file->getRealPath();
                $relativePath = $class_name . '_' . $assignment_name . '/' . substr($filePath, strlen($path) + 1);

                $zip->addFile($filePath, $relativePath);
            }
        }
        $zip->close();
        $filename = basename($zip_file);
        return response()->file($zip_file, ['filename' => urlencode($filename)])->deleteFileAfterSend();
    }
    public function upload_file(Request $data)
    {
        $assignment = Assignment::find($data->assignment_id);
        if (!$assignment->getUserClass_user_ids()->contains(Auth::user()->id)) {
            return response()->json(['error' => '權限不符，並非課程學生'], 402);
        }

        $now = Carbon::now();
        if ($now->isBefore($assignment->start_at) || $now->isAfter($assignment->end_at)) {
            return response()->json(['error' => '不在繳交作業的期限內'], 402);
        }
        $file = $data->file('file');

        $filename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $extension = $file->getClientOriginalExtension();

        $final_file = $filename . '.' . $extension;

        $directory = public_path('uploads/assignment/' . $data->assignment_id . '/' . Auth::user()->account);

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
        if (!$assignment->getUserClass_user_ids()->contains(Auth::user()->id)) {
            return response()->json(['error' => '權限不符，並非課程學生'], 402);
        }
        $now = Carbon::now();
        if ($now->isBefore($assignment->start_at) || $now->isAfter($assignment->end_at)) {
            return response()->json(['error' => '不在繳交作業的期限內'], 402);
        }
        $files = scandir(public_path('uploads/assignment/' . $data->assignment_id . '/' . Auth::user()->account));
        $file_count = count($files) - 2;
        foreach ($files as $file) {
            if (strpos($file, $data->file_name) === 0) {
                unlink(public_path('uploads/assignment/' . $data->assignment_id . '/' . Auth::user()->account) . DIRECTORY_SEPARATOR . $file);
            }
        }
        if ($file_count - 1 == 0) {
            rmdir(public_path('uploads/assignment/' . $data->assignment_id . '/' . Auth::user()->account));
        }
        return response()->json(['success' => 'success delete', 'test' => $file_count], 200);
    }

    public function get_hand_in_assignment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'assignment_id' => 'required_without:hand_in_assignment_id|nullable|exists:assignments,id',
            'hand_in_assignment_id' => 'required_without:assignment_id|nullable|exists:hand_in_assignments,id',
        ], [
            'assignment_id.exists' => '作業不存在',
            'hand_in_assignment_id.exists' => '繳交的作業不存在',
            'required_without' => '請至少填入一欄'
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        if ($data->hand_in_assignment_id) {
            $assignment = HandInAssignment::find($data->hand_in_assignment_id)->Assignment;
        } else if ($data->assignment_id) {
            $assignment = Assignment::find($data->assignment_id);
        }
        if (
            $assignment->getTeacherClass_Teacher_user_id() != Auth::user()->id &&
            !$assignment->getTeacherClass_TA_user_ids()->contains(Auth::user()->id) &&
            !$assignment->getUserClass_user_ids()->contains(Auth::user()->id)
        ) {
            return response()->json(['error' => '權限不符，並非此課程教授、TA、學生'], 402);
        }

        if ($data->hand_in_assignment_id) {
            $handinassignment = HandInAssignment::find($data->hand_in_assignment_id);
            $handinassignment->post_id = $handinassignment->fresh()->TemPost?->post_id;
        } else if ($data->assignment_id) {
            $handinassignment = Assignment::find($data->assignment_id)->HandInAssignment;
            $handinassignment->map(function ($item) {
                return $item->post_id = $item->fresh()->TemPost?->post_id;
            });
        }
        return response()->json(['success' => $handinassignment], 200);
    }

    public function hand_in_assignment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'assignment_id' => 'required|exists:assignments,id',
            'hand_in_assignment_id' => 'nullable|exists:hand_in_assignments,id',
            'post_id' => 'nullable|exists:posts,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'post_id.exists' => '貼文不存在',
            'assignment_id.exists' => '作業不存在',
            'hand_in_assignment_id.exists' => '繳交的作業不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        $assignment = Assignment::find($data->assignment_id);

        if (!$assignment->getUserClass_user_ids()->contains(Auth::user()->id)) {
            return response()->json(['error' => '權限不符，並非課程學生'], 402);
        }

        $now = Carbon::now();
        if ($now->isBefore($assignment->start_at) || $now->isAfter($assignment->end_at)) {
            return response()->json(['error' => '不在繳交作業的期限內'], 402);
        }
        if ($data->post_id && Auth::user()->Post->pluck('id')->doesntContain($data->post_id)) {
            return response()->json(['error' => '此貼文並非您發布，請重新輸入'], 402);
        }

        $temppost = '';
        $match = ['user_id' => Auth::user()->id, 'assignment_id' => $data->assignment_id];

        if ($data->post_id) {
            $post = Post::find($data->post_id);

            $temppost = TempPost::updateOrCreate($match, [
                'user_id' => Auth::user()->id,
                'post_id' => $data->post_id,
                'assignment_id' => $data->assignment_id,
                'uva_topic_id' => $post->uva_topic_id,
                'video_url' => $post->video_url,
                'video_id' => $post->video_id,
                'video_pic_url' => $post->video_pic_url,
                'content' => $post->content,
                'code' => $post->code,
                'code_editor_type' => $post->code_editor_type,
                'code_type' => $post->code_type
            ]);
        }

        $hand_in_assignment = HandInAssignment::updateOrCreate($match, [
            'user_id' => Auth::user()->id,
            'assignment_id' => $data->assignment_id,
            'temp_post_id' => $temppost->id ?? null,
            'file' => $data->file,
        ]);

        if (!$data->post_id && $data->file == []) {
            $hand_in_assignment->delete();
        }
        if ($hand_in_assignment->wasRecentlyCreated) {
            return response()->json(['success' => '成功繳交作業', 'temp_post_id' => $temppost->id ?? ''], 200);
        } else {
            return response()->json(['success' => '成功更新作業', 'temp_post_id' => $temppost->id ?? ''], 200);
        }
    }

    public function correct_hand_in_assignment(Request $data)
    {
        $validator = Validator::make($data->all(), [
            'assignment_id' => 'required|exists:assignments,id',
            'user_id' => 'required|exists:users,id',
        ], [
            'required' => '欄位沒有填寫完整!',
            'assignment_id.exists' => '作業不存在',
            'user_id.exist' => '用戶不存在',
        ]);
        if($validator->fails()){
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        $assignment = Assignment::find($data->assignment_id);
        if(
            $assignment->getTeacherClass_Teacher_user_id() != Auth::user()->id &&
            !$assignment->getTeacherClass_TA_user_ids()->contains(Auth::user()->id)
        ){
            return response()->json(['error' => '權限不符，並非此課程教授、TA'], 402);
        }
        $hand_in_assignment = $assignment->HandInAssignment->where('user_id', $data->user_id)->first();
        if(!$hand_in_assignment){
            return response()->json(['error' => '此學生沒有修此課或尚未繳交作業'], 402);
        }
        if($hand_in_assignment->status == 1){
            $hand_in_assignment->decrement('status');
            return response()->json(['success' => '批改取消', 'status' => $hand_in_assignment->status], 200);
        }else if($hand_in_assignment->status == 0){
            $hand_in_assignment->increment('status');
            return response()->json(['success' => '批改成功', 'status' => $hand_in_assignment->status], 200);
        }
    }
}

