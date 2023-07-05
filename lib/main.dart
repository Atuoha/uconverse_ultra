import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uconverse_ultra/common/routes/pages.dart';
import 'package:uconverse_ultra/common/style/theme.dart';

import 'common/style/color.dart';
import 'firebase_options.dart';
import 'global_config/global.dart';

Future<void> main() async {
  await Global.init(); // global init

  runApp(const UconverseApp());
}

class UconverseApp extends StatelessWidget {
  const UconverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: AppColor.primaryColorLite,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) => GetMaterialApp(
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
      ),
    );
  }
}
