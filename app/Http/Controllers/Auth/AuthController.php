<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use Image;
use Illuminate\Support\Facades\Storage;

/**
 * @OA\Post(
 *      path="/auth/register",
 *      operationId="registerUser",
 *      tags={"Users"},
 *      summary="Register a new user",
 *      description="Registers a new user with the given details",
 *      @OA\RequestBody(
 *          required=true,
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="name",
 *                  type="string",
 *                  description="User name"
 *              ),
 *              @OA\Property(
 *                  property="account",
 *                  type="string",
 *                  description="User account"
 *              ),
 *              @OA\Property(
 *                  property="email",
 *                  type="string",
 *                  description="User email"
 *              ),
 *              @OA\Property(
 *                  property="password",
 *                  type="string",
 *                  description="User password"
 *              )
 *          )
 *      ),
 *      @OA\Response(
 *          response=200,
 *          description="Successful registration",
 *          @OA\JsonContent(
 *              type="object",
 *              @OA\Property(
 *                  property="id",
 *                  type="integer",
 *                  description="User ID"
 *              ),
 *              @OA\Property(
 *                  property="name",
 *                  type="string",
 *                  description="User name"
 *              ),
 *              @OA\Property(
 *                  property="account",
 *                  type="string",
 *                  description="User account"
 *              ),
 *              @OA\Property(
 *                  property="email",
 *                  type="string",
 *                  description="User email"
 *              )
 *          )
 *      ),
 *      security={
 *          {"bearerAuth": {}}
 *      }
 * )
 * */
 
class AuthController extends Controller
{
    public function isadmin()
    {
        return response()->json(['check' => Auth::user()->isadmin], 200);
    }
    public function register(Request $data)
    {
        $validator = Validator::make($data->all(),[
            'name' => 'required',
            'account' => 'required|unique:App\Models\User,account|regex:/^s\d+$/',
            'email' => 'required|email|unique:App\Models\User,email',
            'password' => 'required' ,
        ],[
            'account.regex' => '學號格式不對，小寫 s 開頭 後面接數字',
            'required' => '欄位沒有填寫完整!',
            'email.email' => '信箱格式錯誤',
            'account.unique' => '帳號已被使用',
            'email.unique' => '信箱已被使用',
        ]);
        if ($validator->fails())
            return response()->json(['error' => $validator->errors()->first()], 402);
        
        $user = User::create([
            'name' => $data->name,
            'account' => $data->account,
            'email' => $data->email,
            'password' => bcrypt($data->password),
            'remember_token' => Str::random(10),
            'picture' => 'uploads/userpic/default_user.png',
            'cover' => 'uploads/coverpic/default_cover.png',
            'intro' => "Hello! I'm " . $data->name . "!"
        ]);
        $token = $user->createToken('Laravel9PassportAuth')->accessToken;
        return response()->json(['success' => $token], 200);
    }

    public function login(Request $data)
    {
        $userdata = [
            'account' => $data->account,
            'password' => $data->password
        ];

        if (Auth::attempt($userdata)){
            $token = auth()->user()->createToken('Laravel9PassportAuth')->accessToken;
            $user = auth()->user();
            return response()->json(['success' => $token, 'user' => $user], 200);
        } else {
            return response()->json(['error' => 'Unauthorised'], 401);
        }
    }

    public function user(Request $data)
    {
        $user_id = '';
        try {
            $user_id = Auth::user()->id;
        } catch (\Throwable $th) {
        }

        $validator = Validator::make($data->all(),[
            'account' => 'required|exists:users,account',
        ],[
            'required' => '欄位沒有填寫完整!',
            'account.exists' => '用戶不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }
        $url_user = User::where('account', $data->account)->first();
        $self = 0;
        if ($url_user->id == $user_id) {
            $self = 1;
        }
        return response()->json(['user' => $url_user, 'self' => $self, 'user_id' => $user_id], 200);
    }

    public function token_user()
    {
        return response()->json(['user' => Auth::user()], 200);
    }

    public function edit_user(Request $data)
    {
        if ($data->picture) {


            $files = scandir(public_path('uploads/userpic/'));
            foreach ($files as $file) {
                if (strpos($file, Auth::user()->account . '_userpic') === 0) {
                    unlink(public_path('uploads/userpic/') . DIRECTORY_SEPARATOR . $file);
                }
            }

            if ($data->reset == 1){
                Auth::user()->update([
                    'picture' => 'uploads/userpic/default_user.png',
                ]);
            } else {
                $filename = Auth::user()->account . '_userpic_' . time() . '.png';
                $save_filename = 'uploads/userpic/' . Auth::user()->account . '_userpic_' . time() . '.png';
                Image::make($data->picture)->resize(300, 300)->save(public_path('uploads/userpic/' . $filename));
                Auth::user()->update([
                    'picture' => $save_filename,
                ]);
            }
        } else if ($data->cover) {
            $files = scandir(public_path('uploads/coverpic/'));
            foreach ($files as $file) {
                if (strpos($file, Auth::user()->account . '_coverpic') === 0) {
                    unlink(public_path('uploads/coverpic/') . DIRECTORY_SEPARATOR . $file);
                }
            }

            if ($data->reset == 1) {
                Auth::user()->update([
                    'cover' => 'uploads/coverpic/default_cover.png',
                ]);
            } else {
                $filename = Auth::user()->account . '_coverpic_' . time() . '.png';
                $save_filename = 'uploads/coverpic/' . Auth::user()->account . '_coverpic_' . time() . '.png';
                Image::make($data->cover)->resize(1500,300)->save(public_path('uploads/coverpic/' . $filename));
                Auth::user()->update([
                    'cover' => $save_filename,
                ]);
            }
        } else {
            if (Auth::user()->email != $data->email) {
                $validator = Validator::make($data->all(),[
                    'email' => 'required|email|unique:App\Models\User,email',
                ],[
                    'required' => '欄位沒有填寫完整!',
                    'email.email' => '信箱格式錯誤',
                    'email.unique' => '信箱已被使用',
                ]);
                if ($validator->fails()){
                    return response()->json(['error' => $validator->errors()->first()], 402);
                }
            }
            Auth::user()->update([
                'name' => $data->name,
                'email' => $data->email,
                'intro' => $data->intro,
                'github' => $data->github,
            ]);
        }
        return response()->json(['user' => '更新成功'], 200);
    }

    public function edit_password(Request $data)
    {
        $validator = Validator::make($data->all(),[
            'account' => 'required|exists:App\Models\User,account',
            'old_password' => 'required',
            'password' => 'required',
        ],[
            'required' => '欄位沒有填寫完整!',
            'account,exists' => '帳號不存在',
        ]);
        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()->first()], 402);
        }

        $userdata = [
            'account' => $data->account,
            'password' => $data->old_password
        ];

        if (Auth::attempt($userdata)) {
            Auth::user()->update([
                'password' => bcrypt($data->password),
            ]);
            return response()->json(['user' => '更新成功'], 200);
        } else {
            return response()->json(['error' => '舊密碼錯誤'], 402);
        }
    }

    public function logout()
    {
        Auth::user()->token()->revoke();
        return response()->json(['success' => '成功登出'], 200);
    }

    public function get_all_user()
    {
        return response()->json(['success' => User::all()], 200);
    }

    public function tidy_user($users)
    {
        $users = $users->map(function ($item, $key){
            return collect([
                'account' => $item['account'],
                'name' => $item['name'],
            ]);
        });
        return $users;
    }
}
