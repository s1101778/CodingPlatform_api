<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\ForgotPasswordController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UvaController;
use App\Http\Controllers\GetLikeController;
use App\Http\Controllers\TestController;
use App\Http\Controllers\GetTagController;
use Illuminate\Support\Facades\Route;
use App\Models\UvaTopic;
use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
1. php artisan migrate
2. php artisan db:seed --class=UvaTopicTableSeeder
3. php artisan passport:install

php artisan make:model Name --migration

php artisan make:migration update_flights_table

php artisan migrate
php artisan migrate:rollback



php artisan route:list 
php artisan queue:clear
sudo supervisorctl restart all
supervisorctl reread
supervisorctl update
php artisan schedule:list 
*/

Route::get('proxy/get_uva_pdf/{serial}',[UvaController::class, 'get_uva_pdf']);

Route::prefix('auth')->group(function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
    Route::get('get_all_user', [AuthController::class, 'get_all_user']);
    Route::post('edit_password', [AuthController::class, 'edit_password']);

    Route::prefix('check')->middleware('auth:api')->group(function (){
        Route::post('isadmin', [AuthController::class, 'isadmin']);
    });

    Route::middleware('auth:api')->group(function (){   
        Route::post('user', [AuthController::class, 'user']);
        Route::post('token_user', [AuthController::class, 'token_user']);
        Route::post('edit_user', [AuthController::class, 'edit_user']);
        Route::post('logout', [AuthController::class, 'logout']);
 
    });
    Route::prefix('reset_password')->group(function (){
        Route::post('send', [ForgotPasswordController::class, 'send_reset_mail']);
        Route::post('check', [ForgotPasswordController::class, 'token_check']);
        Route::post('reset', [ForgotPasswordController::class, 'check_reset_mail']);
    });
});

Route::prefix('forum')->group(function () {
    Route::prefix('check')->middleware('auth:api')->group(function () {
        Route::post('user_post_check', [PostController::class, 'user_post_check']);
    });
    Route::middleware('auth:api')->group(function () {
        Route::post('post', [PostController::class, 'post']);
        Route::post('get_user_post', [PostController::class, 'get_user_post']);
        Route::post('like_post', [PostController::class, 'like_post']);
        Route::post('del_post', [PostController::class, 'del_post']);
        Route::post('comment',[CommentController::class,'comment']);
        Route::post('like_comment', [CommentController::class,'like_comment']);
        Route::post('del_comment',[CommentController::class,'del_comment']);
        Route::post('get_like', [GetLikeController::class,'get_like']);
        Route::post('get_tags',[GetTagController::class,'get_tags']);
        Route::post('all_tag_view',[GetTagController::class,'all_tag_view']);
    });
    Route::get('get_uva', [UvaController::class, 'get_uva']);
    Route::post('get_post', [PostController::class, 'get_post']);
    Route::post('get_comment',[CommentController::class,'get_comment']);
    Route::post('get_children_comment',[CommentController::class,'get_children_comment']);
    Route::post('check_is_children_comment',[CommentController::class,'check_is_children_comment']);
    Route::post('tag_viewed',[GetTagController::class,'tag_viewed']);
});




Route::prefix('test')->group(function (){
    Route::get('test1', [TestController::class, 'test1']);
    Route::get('test2', [TestController::class, 'test2']);
    Route::get('test3', [TestController::class, 'test3']);
    Route::get('test4', [TestController::class, 'test4']);
});
