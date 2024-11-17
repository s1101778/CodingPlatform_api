<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Mail;

/**
 * @OA\Get(
 *      path="/api/users",
 *      operationId="getUsersList",
 *      tags={"Users"},
 *      summary="Get list of users",
 *      description="Returns list of users",
 *      @OA\Response(
 *          response=200,
 *          description="Successful operation",
 *          @OA\JsonContent(
 *              type="array",
 *              @OA\Items(   
 *                  type="object",   
 *                  @OA\Property(
 *                      property="id",
 *                      type="integer",
 *                      description="User ID"
 *                  ),
 *                  @OA\Property(
 *                      property="name",
 *                      type="string",
 *                      description="User name"
 *                  ),
 *                  @OA\Property(
 *                      property="email",
 *                      type="string",
 *                      description="User email"
 *                  )
 *              )
 *          )
 *      ),
 *      security={
 *          {"bearerAuth": {}}
 *      }
 * )
 * 
 * @OA\Info(
 *      version="1.0.0",
 *      title="CodingPlatform Documentation",
 *      description="CodingPlatform Documentation",
 *      @OA\Contact(
 *          name="API document",
 *          email="s1101778@gm.pu.edu.tw"
 *      )
 * )
 *
 * @OA\Server(
 *      url=L5_SWAGGER_CONST_HOST,
 *      description="CodingPlatform API Server"
 * )
 */


class Controller extends BaseController
{
    use AuthorizesRequests, ValidatesRequests;
    
    public function sendmail()
    {
        // Mail::raw('測試郵件', function ($message){
        //    $message->from('root@gm.pu.edu.tw', 'root');
        //    $message->to('a0979860416@gmail.com', 'a0979860416')->subject('網域發信');
        // });
        return response()->json([
            'message' => 'Successfully logged out'
        ]);
    }
}
