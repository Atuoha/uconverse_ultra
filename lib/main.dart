import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:uconverse_ultra/common/routes/pages.dart';
import 'package:uconverse_ultra/common/style/theme.dart';

import 'common/style/color.dart';
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
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    EasyLoading.instance
      ..backgroundColor = AppColor.accentColorLite
      ..progressColor = Colors.white
      ..loadingStyle = EasyLoadingStyle.light;

    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) => GetMaterialApp(
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
