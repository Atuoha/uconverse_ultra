import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/message/index.dart';
import '../../common/routes/names.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();

  Future<void> navigateToProfile() async{
   await Get.toNamed(AppRoutes.profile);
  }

  // navigate to contacts
  Future<void> navigateToContacts()async{
    await Get.toNamed(AppRoutes.contact);
  }
}
