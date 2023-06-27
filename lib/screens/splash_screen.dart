import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/services.dart';
import '../components/splash_container.dart';
import '../constants/colors.dart';
import '../generated/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  int currentPageIndex = 0;
  LiquidController? liquidController;
  UpdateType? updateType;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    const SplashContainer(
      title: 'Feel the vibes of others',
      subtitle: 'allowing the springs of others to find you',
      imageAsset: Assets.imagesSlide4,
      backgroundColor: primaryColor,
      textColor: Colors.white,
    ),
    const SplashContainer(
      title: 'Grow outside yor space',
      subtitle: 'reaching out to more stands outside your space',
      imageAsset: Assets.imagesSlider2,
      backgroundColor: buttonColor,
      textColor: Colors.white,
    ),
     const SplashContainer(
      title: 'Find new people',
      subtitle: 'discovering awesome new people around you',
      imageAsset: Assets.imagesSlider3,
      backgroundColor: accentColor,
      textColor: Colors.white,
    ),
    const SplashContainer(
      title: 'An Open World',
      subtitle: 'a place you\'ll feel more connected with people',
      imageAsset: Assets.imagesChatting,
      backgroundColor: Colors.white,
      textColor: primaryColor,
      isLast: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            fullTransitionValue: 500,
            onPageChangeCallback: pageChangeCallback,
            waveType: WaveType.liquidReveal,
            liquidController: liquidController,
            preferDragFromRevealedArea: true,
            enableSideReveal: true,
            ignoreUserGestureWhileAnimating: true,
            enableLoop: true,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                const Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    pages.length,
                    _buildDot,
                  ),
                ),
              ],
            ),
          ),

          // Skip to End Button
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  liquidController!
                      .animateToPage(page: pages.length - 1, duration: 700);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black),
                child: liquidController!.currentPage + 1 == pages.length
                    ? const SizedBox.shrink()
                    : const Text(
                        "Skip to End",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),

          // Next button
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextButton(
                onPressed: () {
                  liquidController!.jumpToPage(
                      page: liquidController!.currentPage + 1 > pages.length - 1
                          ? 0
                          : liquidController!.currentPage + 1);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black),
                child: liquidController!.currentPage + 1 == pages.length
                    ? const SizedBox.shrink()
                    : const Text("Next", style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }

  // page change callback
  pageChangeCallback(int page) {
    setState(() {
      currentPageIndex = page;
    });
  }

  // build dot
  Widget _buildDot(int index) {
    double selectedNess = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((currentPageIndex) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedNess;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }
}
