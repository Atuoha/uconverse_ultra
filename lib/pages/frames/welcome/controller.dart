import 'package:get/get.dart';
import '../../../common/routes/names.dart';
import '../../../generated/assets.dart';
import 'state.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  final title = 'Uconverse';
  final subTitle = '...conversing without limits';

  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAllNamed(AppRoutes.splash),
    );

    print(' WelcomeState');
  }
}
