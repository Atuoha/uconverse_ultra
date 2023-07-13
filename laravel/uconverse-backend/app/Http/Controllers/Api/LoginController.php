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


    // login user
    public function login(Request $request){
        // return ['data'=>"Hello this is working",'code'=>1,'msg'=>"It is reaching here"];


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
        

        try{

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
                return ['code'=>0,'data'=>$result,'msg'=>'User information updated'];
            }
        }catch(Exception $e){
            return ['code'=>-1,'data'=>'An error occurred','msg'=>'An error occurred. ERROR: '.$e];
        }
      
    }


    // fetch all contacts except logged in user
    public function contact(Request $request){
        $token =  $request->user_token;
        $res = DB::table('users').select('avatar','online','description','token')->where('token', '!=', $token)->get();

        return ['code'=>0,'data'=>$res,'msg'=>'Here are all the users'];
    }

    public function get_profile(Request $request){

    }


    
}