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
            return ['code'=>0,'data'=>$result,'msg'=>'no user found'];
        }
    }

    public function get_profile(Request $request){

    }
}