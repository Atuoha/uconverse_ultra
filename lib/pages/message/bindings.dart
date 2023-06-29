import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/message/controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
