import 'package:get/get.dart';

class VoiceCallState {
  var toName = "".obs;
  var toAvatar = "".obs;
  var toToken = "".obs;
  var docId = "".obs;
  var channelId = "".obs;

  RxBool isJoined = false.obs;
  RxBool isMicrophoneOn = true.obs;
  RxBool isSpeakerOn = true.obs;
  RxString callTime = "calling".obs;
  RxBool callStatus = false.obs;
  var callRole = "audience".obs;
}
