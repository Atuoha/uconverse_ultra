<?php
namespace App\Http\Controllers\Api;
use Exception;
use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Carbon;
use \Illuminate\Support\Facades\DB;

class ContactController extends Controller{

    // fetch all contacts except logged in user
    public function contact(Request $request){
        $token =  $request->user_token;
        $res = DB::table('users')->select('avatar','online','description','token','name')->where('token', '!=', $token)->get();

        return ['code'=>0,'data'=>$res,'msg'=>'Here are all the users'];
    }

   
}