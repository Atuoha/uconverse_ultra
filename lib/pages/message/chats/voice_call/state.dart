import 'package:get/get.dart';

class VoiceCallState {
  var toName = "".obs;
  var toAvatar = "".obs;

  RxBool isJoined = false.obs;
  RxBool isMicrophoneOn = true.obs;
  RxBool isSpeakerOn = true.obs;
  RxString callTime = "calling".obs;
}
