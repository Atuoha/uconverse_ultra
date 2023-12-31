import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uconverse_ultra/common/entities/chat.dart';
import '../../../../common/apis/chat.dart';
import '../../../../common/store/user.dart';
import '../../../../common/values/server.dart';
import '../../../../generated/assets.dart';
import 'index.dart';
import 'package:just_audio/just_audio.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();

  final state = VoiceCallState();
  final player = AudioPlayer();
  final appId = APPID;
  final db = FirebaseFirestore.instance;
  final profileToken = UserStore.to.token;
  late final RtcEngine engine;

  @override
  void onInit() {
    initAgoraEngine();

    super.onInit();

    var params = Get.parameters;
    state.toName.value = params['toName'] ?? "";
    state.toAvatar.value = params['toAvatar'] ?? "";
    state.toToken.value = params['toToken'] ?? "";
    state.docId.value = params['docId'] ?? "";
    state.callRole.value = params['call_role'] ?? "";
  }

  Future<void> initAgoraEngine() async {
    await player.setAsset(Assets.soundEffectsSound);

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: appId));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onError: (ErrorCodeType err, String msg) {
          print('{onError: $err, msg: $msg');
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          print('Connection: ${connection.toJson()}');
          state.isJoined.value = true;
        },
        onUserJoined:
            (RtcConnection connection, int remoteUid, int elapsedTime) async {
          await player.pause();
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          print('User hanged up the call');
          state.isJoined.value = false;
        },
        onRtcStats: (RtcConnection connection, RtcStats stats) {
          print('Duration: ${stats.duration}');
          state.callTime.value = stats.duration.toString();
        },
      ),
    );

    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );

    await joinChannel();
    if (state.callRole.value == "anchor") {
      sendNotification(callType:"voice");
      await player.play();
    }
  }


  Future<void> sendNotification({required String callType})async{
    CallRequestEntity callRequestEntity = CallRequestEntity();
    callRequestEntity.call_type =  callType;
    callRequestEntity.to_token = state.toToken.value;
    callRequestEntity.to_name = state.toName.value;
    callRequestEntity.to_avatar = state.toAvatar.value;
    callRequestEntity.doc_id = state.docId.value;

    
    print('.... TO_TOKEN ${state.toToken.value}');
    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    if(res.code == 0){
      print('notification success');
    }else{
      print('notification failure');
    }
  }

  Future<String> getToken() async {
    if (state.callRole.value == "anchor") {
      state.channelId.value = md5
          .convert(utf8.encode('${profileToken}_${state.toToken}'))
          .toString();
    } else {
      state.channelId.value =
          md5.convert(utf8.encode('${state.toToken}_$profileToken')).toString();
    }

    CallTokenRequestEntity callTokenRequestEntity = CallTokenRequestEntity();
    callTokenRequestEntity.channel_name = state.channelId.value;
    print('......channel id ${state.channelId.value}');
    var res = await ChatAPI.call_token(params: callTokenRequestEntity);

    if (res.code == 0) {
      return res.data!;
    }

    return "";
  }

  Future<void> joinChannel() async {
    await Permission.microphone.request();
    EasyLoading.show();

    String token = await getToken();

    if (token.isEmpty) {
      EasyLoading.dismiss();
      Get.back();
      return;
    }

    await engine.joinChannel(
      token: token,
      channelId:state.channelId.value,
      uid: 0,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileCommunication,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );

    EasyLoading.dismiss();
  }

  Future<void> leaveChannel() async {
    EasyLoading.show();

    await player.pause();
    state.isJoined.value = false;
    EasyLoading.dismiss();
    Get.back();
  }

  void toggleSpeaker() {
    state.isSpeakerOn.value = !state.isSpeakerOn.value;
  }

  void toggleMicrophone() {
    state.isMicrophoneOn.value = !state.isMicrophoneOn.value;
  }

  Future<void> disposeAll() async {
    await player.pause();
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
  }

  @override
  void dispose() {
    disposeAll();
    super.dispose();
  }

  @override
  void onClose() {
    disposeAll();
    super.onClose();
  }
}
