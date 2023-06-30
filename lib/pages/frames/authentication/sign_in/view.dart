import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/frames/authentication/sign_in/controller.dart';

import '../../../../common/style/color.dart';
import '../../../../generated/assets.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          left: 18,
          right: 18,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesUconverseTransparent,
              width: 100.sp,
            ),
            const SizedBox(height: 25),
            buildThirdPartyLogin(
              title: 'Google',
              imgUrl: Assets.iconsGoogle,
              fnc: () => null,
            ),
            const SizedBox(height: 10),
            buildThirdPartyLogin(
              title: 'Apple',
              imgUrl: Assets.iconsApple,
              fnc: () => null,
            ),
            const SizedBox(height: 10),
            buildThirdPartyLogin(
              title: 'Facebook',
              imgUrl: Assets.iconsFacebook,
              fnc: () => null,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    indent: 50,
                    color: AppColor.secondaryColor,
                    height: 2.h,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('or'),
                ),
                Expanded(
                  child: Divider(
                    endIndent: 50,
                    color: AppColor.secondaryColor,
                    height: 2.h,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.h),
            const Text('Already have an account?'),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: null,
              child: const Text(
                'Sign up',
                style: TextStyle(
                  color: AppColor.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Third party login
  Widget buildThirdPartyLogin({
    required String title,
    required String imgUrl,
    required Function fnc,
  }) {
    return GestureDetector(
      onTap: () => fnc,
      child: Container(
        width: 215.w,
        height: 44.h,
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              offset: Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Image.asset(imgUrl, width: 20.w),
            ),
            Text(
              'Sign in with $title',
              style: const TextStyle(
                color: AppColor.secondaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
