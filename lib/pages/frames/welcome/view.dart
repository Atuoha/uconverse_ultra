import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/common/style/color.dart';
import 'package:uconverse_ultra/pages/frames/welcome/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(controller.appLogo),
          const SizedBox(height: 2),
          Text(
            controller.title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w700,
              color: AppColor.primaryColor,
              fontSize: 29.sp,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            controller.subTitle,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
              color: AppColor.primaryColor,
              fontSize: 15.sp,
            ),
          )
        ],
      ),
    );
  }
}
