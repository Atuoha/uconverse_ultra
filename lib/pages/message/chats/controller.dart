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


  void toggleAttachmentBtnExpansion(){
    state.isAttachBtnExpanded = !state.isAttachBtnExpanded;
    print(state.isAttachBtnExpanded);
  }

}
