import 'package:flutter/material.dart';
import 'package:uconverse_ultra/common/routes/routes.dart';
import 'package:uconverse_ultra/common/store/store.dart';

import 'package:get/get.dart';

/// 检查是否登录
class RouteAuthMiddleware extends GetMiddleware {
  // priority 数字小优先级高
  @override
  int? priority = 0;

  RouteAuthMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin ||
        route == AppRoutes.signIn ||
        route == AppRoutes.initial) {
      return null;
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => Get.snackbar(
          "Tips",
          "Login expired, please login again!",
        ),
      );
      return const RouteSettings(name: AppRoutes.signIn);
    }
  }
}
