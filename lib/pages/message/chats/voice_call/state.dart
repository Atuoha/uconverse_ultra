import 'package:get/get.dart';

class VoiceCallState {
  var toName = "".obs;
  var toAvatar = "".obs;

  RxBool isJoined = false.obs;
  RxBool isMicrophoneOn = false.obs;
  RxBool isSpeakerOn = false.obs;
}
