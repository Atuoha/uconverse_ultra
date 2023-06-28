import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import '../../../common/style/color.dart';
import '../../../generated/assets.dart';
import '../../../common/widgets/splash_container.dart';

class SplashController extends GetxController {
  SplashController();

  final state = SplashState();

  int currentPageIndex = 0;

  // page change callback
  void pageChangeCallback(int page) {
    currentPageIndex = page;
  }

  final pages = [
    const SplashContainer(
      title: 'Feel the vibes of others',
      subtitle: 'allowing the springs of others to find you',
      imageAsset: Assets.imagesSlide4,
      backgroundColor: AppColor.primaryColor,
      textColor: Colors.white,
    ),
    const SplashContainer(
      title: 'Grow outside yor space',
      subtitle: 'reaching out to more stands outside your space',
      imageAsset: Assets.imagesSlider2,
      backgroundColor: AppColor.buttonColor,
      textColor: Colors.white,
    ),
    const SplashContainer(
      title: 'Find new people',
      subtitle: 'discovering awesome new people around you',
      imageAsset: Assets.imagesSlider3,
      backgroundColor: AppColor.accentColor,
      textColor: Colors.white,
    ),
    const SplashContainer(
      title: 'An Open World',
      subtitle: 'a place you\'ll feel more connected with people',
      imageAsset: Assets.imagesChatting,
      backgroundColor: Colors.white,
      textColor: AppColor.primaryColor,
      isLast: true,
    ),
  ];

  @override
  void onReady() {
    super.onReady();
    print('Splash Screen');
  }

  // this is called after splash screen
  void launchApp() {
    print('launching App....');
  }
}
