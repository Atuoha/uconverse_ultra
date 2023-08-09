import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/message/index.dart';
import '../../common/entities/base.dart';
import '../../common/routes/names.dart';
import '../../common/apis/chat.dart';


class MessageController extends GetxController {
  MessageController();

  final state = MessageState();

  Future<void> navigateToProfile() async {
    await Get.toNamed(AppRoutes.profile);
  }

  // navigate to contacts
  Future<void> navigateToContacts() async {
    await Get.toNamed(AppRoutes.contact);
  }

  @override
  onReady() {
    firebaseMessageSetup();
  }

  Future firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('.........Device Token $fcmToken');
    if (fcmToken != null) {
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity =
          BindFcmTokenRequestEntity();
      bindFcmTokenRequestEntity.fcmtoken = fcmToken;
      await ChatAPI.bind_fcmtoken(params:bindFcmTokenRequestEntity);
    }
  }
}
