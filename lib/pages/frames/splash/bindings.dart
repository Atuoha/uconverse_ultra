import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/frames/splash/controller.dart';

class SplashBinding implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
