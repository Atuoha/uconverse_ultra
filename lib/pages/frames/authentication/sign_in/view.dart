import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/frames/authentication/sign_in/controller.dart';
import '../../../../common/enums/sign_in_type.dart';
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
              width: 110.sp,
            ),
            const SizedBox(height: 25),
            buildLoginMechanism(
              title: 'Google',
              imgUrl: Assets.iconsGoogle,
              type: SignInType.google,
            ),
            SizedBox(height: 15.h),
            buildLoginMechanism(
              title: 'Apple',
              imgUrl: Assets.iconsApple,
              type: SignInType.apple,
            ),
            SizedBox(height: 15.h),
            buildLoginMechanism(
              title: 'Facebook',
              imgUrl: Assets.iconsFacebook,
              type: SignInType.facebook,
            ),
            SizedBox(height: 20.h),
            buildOrWidget(),
            SizedBox(height: 25.h),
            buildLoginMechanism(
              title: 'email',
              imgInvolved: false,
              type: SignInType.email,
            ),
            SizedBox(height: 15.h),
            buildLoginMechanism(
              title: 'phone number',
              imgInvolved: false,
              type: SignInType.phone,
            ),
            SizedBox(height: 30.h),
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

  // OR Widget
  Widget buildOrWidget() {
    return Row(
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
    );
  }

  // Login mechanism
  Widget buildLoginMechanism({
    required String title,
    String imgUrl = '',
    required SignInType type,
    bool imgInvolved = true,
  }) {
    return GestureDetector(
      onTap: () => controller.handleSignIn(type),
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
              offset: const Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment:
              imgInvolved ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            imgInvolved
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Image.asset(imgUrl, width: 20.w),
                  )
                : const SizedBox.shrink(),
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
