<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\ForgotPasswordController;
use App\Http\Controllers\Class\AssignmentController;
use App\Http\Controllers\Class\HandInAssignmentController;
use App\Http\Controllers\Class\TAController;
use App\Http\Controllers\Class\TeacherClassController;
use App\Http\Controllers\Class\UserClassController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\GetSubscribeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UvaController;
use App\Http\Controllers\UvaCodeController;
use App\Http\Controllers\GetLikeController;
use App\Http\Controllers\TestController;
use App\Http\Controllers\GetTagController;
use App\Http\Controllers\GetViewController;
use App\Http\Controllers\CommunityController;
use App\Http\Controllers\NoteController;
use App\Http\Controllers\SearchController;
use Illuminate\Support\Facades\Route;
use App\Models\UvaTopic;
use Illuminate\Http\Request;


Route::get('proxy/get_uva_pdf/{serial}', [UvaController::class, 'get_uva_pdf']);
Route::get('proxy/get_uva_code_pdf/{serial}', [UvaCodeController::class, 'get_uva_code_pdf']);

Route::prefix('class')->middleware('auth:api')->group(function () {
    Route::post('upload_file', [HandInAssignmentController::class, 'upload_file']);
    Route::post('delete_file', [HandInAssignmentController::class, 'delete_file']);
    Route::post('get_hand_in_assignment', [HandInAssignmentController::class, 'get_hand_in_assignment']);
    Route::post('hand_in_assignment', [HandInAssignmentController::class, 'hand_in_assignment']);
    Route::post('get_assignment', [AssignmentController::class, 'get_assignment']);

    Route::post('get_user_class', [UserClassController::class, 'get_user_class']);
    Route::post('user_class', [UserClassController::class, 'user_class']);
    Route::post('del_user_class', [UserClassController::class, 'del_user_class']);

    Route::post('get_coding_class', [UserClassController::class, 'get_coding_class']);
    Route::post('get_class_user', [UserClassController::class, 'get_class_user']);

    Route::prefix('admin')->middleware('isAdmin')->group(function () {
        Route::post('ouput_file', [HandInAssignmentController::class, 'ouput_file']);
        Route::post('correct_hand_in_assignment', [HandInAssignmentController::class, 'correct_hand_in_assignment']);

        Route::post('get_teacher_class', [TeacherClassController::class, 'get_teacher_class']);
        Route::post('teacher_class', [TeacherClassController::class, 'teacher_class']);
        Route::post('del_teacher_class', [TeacherClassController::class, 'del_teacher_class']);

        Route::post('assignment', [AssignmentController::class, 'assignment']);
        Route::post('del_assignment', [AssignmentController::class, 'del_assignment']);
        Route::post('upload_file', [AssignmentController::class, 'upload_file']);
        Route::post('delete_file', [AssignmentController::class, 'delete_file']);
    });
    Route::prefix('TA')->middleware('isTA')->group(function () {
        Route::post('ouput_file', [HandInAssignmentController::class, 'ouput_file']);

        Route::post('get_TA_class', [TAController::class, 'get_TA_class']);
    });

});

Route::prefix('auth')->group(function () {
    Route::post('register', [AuthController::class, 'register']);
    Route::post('login', [AuthController::class, 'login']);
    Route::get('get_all_user', [AuthController::class, 'get_all_user']);
    Route::post('edit_password', [AuthController::class, 'edit_password']);

    Route::prefix('check')->middleware('auth:api')->group(function () {
        Route::post('isadmin', [AuthController::class, 'isadmin']);
    });

    Route::middleware('auth:api')->group(function () {
        Route::post('user', [AuthController::class, 'user']);
        Route::post('token_user', [AuthController::class, 'token_user']);
        Route::post('edit_user', [AuthController::class, 'edit_user']);
        Route::post('logout', [AuthController::class, 'logout']);

    });
    Route::prefix('reset_password')->group(function () {
        Route::post('send', [ForgotPasswordController::class, 'send_reset_mail']);
        Route::post('check', [ForgotPasswordController::class, 'token_check']);
        Route::post('reset', [ForgotPasswordController::class, 'check_reset_mail']);
    });
});

Route::prefix('forum')->group(function () {
    Route::prefix('check')->middleware('auth:api')->group(function () {
        Route::post('user_post_check', [PostController::class, 'user_post_check']);
		Route::post('user_community_check', [CommunityController::class, 'user_community_check']);
    });
    Route::middleware('auth:api')->group(function () {
        Route::post('post', [PostController::class, 'post']);
        Route::post('del_post', [PostController::class, 'del_post']);
        Route::post('get_user_post', [PostController::class, 'get_user_post']);
        Route::post('comment', [CommentController::class, 'comment']);
        Route::post('del_comment', [CommentController::class, 'del_comment']);
        Route::post('like_post', [GetLikeController::class, 'like_post']);
		Route::post('like_community', [GetLikeController::class, 'like_community']);
        Route::post('like_comment', [GetLikeController::class, 'like_comment']);
        Route::post('get_like', [GetLikeController::class, 'get_like']);
        Route::post('get_like_post', [GetLikeController::class, 'get_like_post']);
		Route::post('get_like_community', [GetLikeController::class, 'get_like_community']);
        Route::post('subscribe_author', [GetSubscribeController::class, 'subscribe_author']);
		Route::post('follow_author', [GetSubscribeController::class, 'follow_author']);
        Route::post('get_subscribe', [GetSubscribeController::class, 'get_subscribe']);
		Route::post('get_follow', [GetSubscribeController::class, 'get_follow']);
        Route::post('get_subscribe_author', [GetSubscribeController::class, 'get_subscribe_author']);
		Route::post('get_follow_author', [GetSubscribeController::class, 'get_follow_author']);
        Route::post('get_post_view', [GetViewController::class, 'get_post_view']);
        Route::post('get_tags', [GetTagController::class, 'get_tags']);
        Route::post('all_tag_view', [GetTagController::class, 'all_tag_view']);
        Route::post('community', [CommunityController::class, 'community']);
        Route::post('del_community', [CommunityController::class, 'del_community']);
        Route::post('note', [NoteController::class, 'note']);
        Route::post('del_note', [NoteController::class, 'del_note']);
        Route::post('get_note', [NoteController::class, 'get_note']);
        Route::post('search_note', [SearchController::class, 'search_note']);
    });
    Route::get('get_uva', [UvaController::class, 'get_uva']);
    Route::get('get_uva_code', [UvaCodeController::class, 'get_uva_code']);
	Route::post('compareoutput', [UvaCodeController::class, 'compareoutput']);
    Route::post('get_post', [PostController::class, 'get_post']);
    Route::post('get_temp_post', [PostController::class, 'get_temp_post']);
    Route::post('get_comment', [CommentController::class, 'get_comment']);
    Route::post('get_children_comment', [CommentController::class, 'get_children_comment']);
    Route::post('check_is_children_comment', [CommentController::class, 'check_is_children_comment']);
    Route::post('tag_viewed', [GetTagController::class, 'tag_viewed']);
    Route::post('get_community', [CommunityController::class, 'get_community']);
});

Route::post('search_community', [SearchController::class, 'search_community']);


Route::get('sendmail', [PostController::class, 'post']);

Route::prefix('test')->group(function () {
    Route::get('test1', [TestController::class, 'test1']);
    Route::get('test2', [TestController::class, 'test2']);
    Route::get('test3', [TestController::class, 'test3']);
    Route::get('test4', [TestController::class, 'test4']);
});