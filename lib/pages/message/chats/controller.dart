import 'package:get/get.dart';
import 'index.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();
  late String docId;

  @override
  void onInit() {
    super.onInit();
    var parameters = Get.parameters;

    docId = parameters['doc_id']!;
    state.toName.value = parameters['to_name'] ?? "";
    state.toAvatar.value = parameters['to_avatar'] ?? "";
    state.toOnline.value = parameters['to_online'] ?? "";
    state.toToken.value = parameters['to_token'] ?? "";
  }

  // toggle attachment widget
  void toggleAttachmentBtnExpansion() {
    state.isAttachBtnExpanded.value = !state.isAttachBtnExpanded.value;
  }

  void fileHandler() {
    print('fileHandler');
  }

  void locationHandler() {
    print('locationHandler');
  }

  void videoCallHandler() {
    print('videoCallHandler');
  }

  void voiceRecordHandler() {
    print('voiceRecordHandler');
  }

  void photoGalleryHandler() {
    print('photoGalleryHandler');
  }

  void phoneCallHandler() {
    print('phoneCallHandler');
  }
}
