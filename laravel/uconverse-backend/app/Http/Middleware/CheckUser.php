<?php

namespace App\Http\Middleware;
use Closure;
use Illuminate\Support\Carbon;
use \Illuminate\Support\Facades\DB;

class CheckUser{
    public function handle($request, Closure $next){
        $Authorization  = $request->header('Authorization');

        if(empty($Authorization)){
            return response(['code'=>401, 'message'=>'Authentication failed!'], 401);
        }

        $access_token = trim(ltrim($Authorization, 'Bearer'));

        $res_user = DB::table('users')->where('access_token','=', $access_token)->select('id','avatar','name','token','type','access_token','expire_date')->first();

        if(empty($res_user)){
            print('User does not exist');
            return response(['code'=>401, 'message'=>'User not found!'], 401);
        }

        $expire_date = $res_user->expire_date;

        if(empty($expire_date)){
            return response(['code'=>401, 'message'=>'You need to login!'], 401);
        }

        if($expire_date < Carbon::now()){
            return response(['code'=>401, 'message'=>'Token expired. You need to login again!'], 401);
        }

        $addTime = Carbon::now()->addDays(5);

        if($expire_date < $addTime){
            $add_more_time = Carbon::now()->addDays(30);
            DB::table('users')->where('access_token','=',$access_token)->update(['expire_date'=>$add_more_time]);
        }

        $request->user_id = $res_user->id;
        $request->user_name = $res_user->name;
        $request->type = $res_user->type;
        $request->user_avatar = $res_user->avatar;
        $request->user_token = $res_user->token;
        $request->access_token = $res_user->access_token;

        return $next($request);
    }
}