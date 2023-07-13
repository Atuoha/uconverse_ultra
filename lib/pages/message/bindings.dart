import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/message/controller.dart';

class MessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(() => MessageController());
  }
}
