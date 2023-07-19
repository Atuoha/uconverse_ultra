import 'package:get/get.dart';
import 'index.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();

  final state = VoiceCallState();

  @override
  void onReady() {
    super.onReady();

    var params = Get.parameters;

    state.toName.value = params['toName'] ?? "";
    state.toAvatar.value = params['toAvatar'] ?? "";
  }


  void toggleSpeaker(){
    state.isSpeakerOn.value = !state.isSpeakerOn.value;
  }

  void toggleMicrophone(){
    state.isMicrophoneOn.value = !state.isMicrophoneOn.value;
  }

}
