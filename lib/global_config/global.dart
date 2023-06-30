import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/common/services/services.dart';
import 'package:uconverse_ultra/common/store/store.dart';

class Global {
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<UserStore>(UserStore());
  }
}
