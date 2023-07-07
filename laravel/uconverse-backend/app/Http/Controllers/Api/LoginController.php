<?php
namespace App\Http\Controllers\Api;
use Exception;
use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Carbon;
use \Illuminate\Support\Facades\DB;

class LoginController extends Controller{

    public function login(Request $request){
        $validator = Validator::make($request->all(),[
            'email'=>'max:50',
            'avatar'=>'required',
            'name'=>'required',
            'phone'=>'max:30',
            'open_id'=>'required',
            'type'=>'required',
        ]);

        if($validator->fails()){
            return ['code'=>-1,'data'=>'no valid data','msg'=>$validator->errors()->first(),];
        }

        $validated =  $validator->validated();
        $map = [];
        $map['type'] = $validated['type'];
        $map['name'] = $validated['name'];

        $result = DB::table('users')->select('avatar','type','description','token','access_token','online')->where($map)->first();

        if(empty($result)){
            $validated['token'] = md5(uniqid().rand(100000,99999));
            $validated['created_at'] = Carbon::now();
            $validated['access_token'] = md5(uniqid().rand(1000000,999999));
            $validated['expire_date'] = Carbon::now()->addDays(30);
            $user_id = DB::table('users')->insertGetId($validated);

            $user_result =  DB::table('users')->select('avatar','type','description','token','access_token','online')->where('id','=',$user_id)->first();

            return ['code'=>0,'data'=>$user_result,'msg'=>'User has been created'];
        }else{
            $access_token = md5(uniqid().rand(1000000,999999));
            $expire_date = Carbon::now()->addDays(30);
            DB::table('users')->where($map)->update(['access_token'=> $access_token, 'expire_date'=> $expire_date]);
            $result->access_token = $access_token;
            return ['code'=>1,'data'=>$result,'msg'=>'User information updated'];
        }
    }

    public function get_profile(Request $request){

    }
}