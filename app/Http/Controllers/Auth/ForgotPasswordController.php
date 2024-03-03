<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Model\PasswordReset;
use Illuminate\Support\Facades\Mail;
use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Mail\Message;
use Illuminate\Support\Facades\Validator;


class ForgotPasswordController extends Controller
{
    public function send_reset_mail(Reques $request)
    {

        $data = Validator::make($request->all(),[
            'email' => 'required|email|exists:users',
        ],[
            'required' => '欄位沒有填寫完整!',
            'email.email' => '信箱格式錯誤',
            'email.exists' => '無此信箱，請確認信箱並重新輸入'
        ]);
        if ($data->fails()) {
            return response()->json(['error' => $data->errors()->first()], 402);
        }

        // Delete all old code that user send before.
        PasswordReset::where('email', $request->email)->delete();

        // Generate random code
        $newdata['token'] = time() . mt_rand(100000, 999999);
        $newdata['email'] = $request->email;
        $newdata['created_at'] = data('Y-m-d H:i:s');

        // Create a new code
        PasswordReset::insert($newdata);

        // Send email to user
        $email = $request->email;
        $user = User::firstWhere('email', $email)->name;

        $website = 'http://127.0.0.1/Coding-platform/CodingPlatform_api/public/api/auth/reset_password/' . $newdata['token'];
        Mail::raw('請點擊網址:' . $website . '前往修改密碼。請注意，此連結僅在申請修改密碼後的一小時內有效。此郵件為系統自動發送。請勿回覆。', function (Message $message) use ($email, $user){
            $message->from('root@gm.pu.edu.tw', '程式交流網');
            $message->to($email, $user)->subject('城市交流網-修改密碼通知');
        });
        return response(['success' => "已成功發送修改密碼郵件"], 200);
    }

    public function token_check(Request $request)
    {
        $data = Validator::make($request->all(),[
            'token' => 'required|string|exists:password_resets,token',
        ],[
            'required' => '欄位沒有填寫完整!',
            'token.exists' => '無此token',
        ]);
        if ($data->fails()){
            return response()->json(['error' => $data->errors()->first()], 402);
        }
        $passwordReset = PasswordReset::firstWhere('token', $request->token);
        if ($passwordReset->created_at->addHour() < now()){
            // PasswordReset::where('token', $request->token)->delete();
            return response(['message' => "連結已過期，請重新申請重置密碼"], 403);
        }
        return response(['message' => "token未過期"], 200);
    }

    public function check_reset_mail(Request $request)
    {
        $data = Validator::make($request->all(), [
            'toke' => 'required|string|exists:password_resets',
            'password' => 'required|confirmed',
            'password_confirmation' => 'required',
        ],[
            'required' => '欄位沒有填寫完整!',
            'token.exists' => '無此token',
            'password.confirmed' => '密碼不一致',
        ]);
        if ($data->fails()){
            return response()->json(['error' => $data->errors()->first()], 402);
        }
        $passwordReset = PasswordReset::firstWhere('token', $request->token);
        if ($passwordReset->created_at->addHour() < now()){
            PasswordReset::where('token', $request->token)->delete();
            return response(['message' => "連結已過期，請重新申請重置密碼"], 402);
        }

        User::firstWhere('email', $passwordReset->email)->update(['password' => bcrypt($request->password)]);

        $passwordReset->delete();
        return response(['message' => "重置密碼成功"], 200);
    }
}
