<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TestController extends Controller
{
    public function test1()
    {

        return response()->json(['success' => 'success'], 200);
    }

    public function test2()
    {

        return response()->json(['success' => 'success'], 200);
    }

    public function test3()
    {
        return response()->json(['success' => 'success'], 200);
    }

    public function test4()
    {
        return response()->json(['success' => 'success'], 200);
    }
}
