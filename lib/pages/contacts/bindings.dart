import 'package:get/get.dart';
import 'controller.dart';

class ContactsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactsController>(()  => ContactsController());
  }
}
