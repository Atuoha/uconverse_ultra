import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/common/services/services.dart';
import 'package:uconverse_ultra/common/store/store.dart';

import '../firebase_options.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Get.putAsync<StorageService>(() => StorageService().init());
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    Get.put<UserStore>(UserStore());
  }
}
