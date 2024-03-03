<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\ForgotPasswordController;
use App\Http\Controllers\Controller;
use App\Http\Controllers\TestController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
php artisan make:model Name --migration
php artisan make:migration update_flights_table
php artisan migrate
php artisan migrate:rollback

php artisan db:seed --class=UvaTopicTableSeeder

php artisan route:list 查看可用
php artisan queue:clear
sudo supervisorctl restart all
supervisorctl reread
supervisorctl update
php artisan schedule:list 查看排程
*/

Route::prefix('auth')->group(function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login',[AuthController::class, 'login']);
    Route::get('get_all_user', [AuthController::class, 'get_all_user']);
    
    Route::prefix('check')->middleware('auth:api')->group(function (){
        Route::post('isadmin', [AuthController::class, 'isadmin']);
    });

    Route::middleware('auth:api')->group(function (){   
        Route::post('logout', [AuthController::class, 'logout']);
 
    });
    Route::prefix('reset_password')->group(function (){
        Route::post('send', [ForgotPasswordController::class, 'send_reset_mail']);
        Route::post('check', [ForgotPasswordController::class, 'token_check']);
        Route::post('reset', [ForgotPasswordController::class, 'check_reset_email']);
    });
});





Route::prefix('test')->group(function (){
    Route::get('test1', [TestController::class, 'test1']);
    Route::get('test2', [TestController::class, 'test2']);
    Route::get('test3', [TestController::class, 'test3']);
    Route::get('test4', [TestController::class, 'test4']);
});
