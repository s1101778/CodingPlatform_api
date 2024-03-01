<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Mail;

class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;

    public function sendmail()
    {
        Mail::raw('測試郵件', function ($message){
            $message->from('root@gm.pu.edu.tw', 'root');
            $message->to('a0979860416@gmail.com', 'a0979860416')->subject('網域發信');
        });
    }
}
