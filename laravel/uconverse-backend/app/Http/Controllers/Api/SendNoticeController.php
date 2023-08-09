<?php
namespace App\Http\Controllers\Api;
use Exception;
use App\Http\Controllers\Controller;
use Illuminate\Auth\Events\Validated;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Carbon;
use \Illuminate\Support\Facades\DB;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Contract\Messaging;

class SendNoticeController extends Controller {

    public function send_notice( Request $request ) {

        // sender info
        $user_token = $request->user_token;
        $user_avatar = $request->user_avatar;
        $user_name = $request->user_name;

        // sendee info
        $to_token =  $request->input( 'to_token' );
        $to_avatar = $request->input( 'to_avatar' );
        $to_name = $request->input( 'to_name' );
        $call_type = $request->input( 'call_type' );
        $doc_id = $request->input( 'doc_id' );

        if ( empty( $doc_id ) ) {
            $doc_id = '';
        }

        $res_user = DB::table( 'users' )->select( 'avatar', 'name', 'fcmtoken' )->where( 'token', '=', $to_token )->first();

        if ( empty( $res_user ) ) {
            return [ 'code'=>-1, 'data'=>'', 'msg'=>'user does not exist' ];
        }

        $device_token = $res_user->fcmtoken;

        try {
            if ( !empty( $device_token ) ) {
                $messaging =  app( 'firebase.messaging' );

                if ( $call_type == 'cancel' ) {
                    $message = CloudMessage::fromArray( [
                        'token'=> $device_token,
                        'data'=> [
                            'token'=> $user_token,
                            'avatar'=>$user_avatar,
                            'name'=>$user_name,
                            'doc_id'=>$doc_id,
                            'call_type'=>$call_type
                        ],
                    ], );

                    $messaging->send( $message );

                } else if ( $call_type == 'voice' ) {
                    $message = CloudMessage::fromArray( [
                        'token'=> $device_token,
                        'data'=> [
                            'token'=> $user_token,
                            'avatar'=>$user_avatar,
                            'name'=>$user_name,
                            'doc_id'=>$doc_id,
                            'call_type'=>$call_type
                        ],
                        'android'=>[
                            'priority'=>'high',
                            'notification'=>[
                                'channel_id'=>'',
                                'title'=> 'Voice call by '.$user_name,
                                'body'=> 'Click to answer call'
                            ]
                        ]
                    ], );
                }

                $messaging->send( $message );

                return ['code'=>0, 'data'=>$to_token, 'msg'=>'success' ];
            } else {
                return [ 'code'=>-1, 'data'=>'', 'msg'=>'Opps! Device token is empty' ];
            }

        } catch( \Exception $e ) {
            return [ 'code'=>-1, 'data'=>'', 'msg'=>( string )$e ];
        }

      
    }



    public function bind_fcmtoken(Request $request){
        $token = $request->user_token;
        $fcmtoken = $request->input('fcmtoken');
        if(empty($fcmtoken)){
            return ['data'=>'','code'=>-1,'msg'=>'Error getting the token'];
        }
        DB::table('users')->where('token','=',$token)->update(['fcmtoken'=>$fcmtoken]);
        return ['code'=>0, 'data'=>$token, 'msg'=>'success'];

    } 

}

?>