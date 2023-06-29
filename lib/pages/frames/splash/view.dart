import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:uconverse_ultra/pages/frames/splash/controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiquidController liquidController = LiquidController();

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: controller.pages,
            fullTransitionValue: 500,
            onPageChangeCallback: controller.pageChangeCallback,
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
                    controller.pages.length,
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
                  liquidController.animateToPage(
                      page: controller.pages.length - 1, duration: 700);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black),
                child:
                    liquidController.currentPage + 1 == controller.pages.length
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
                  liquidController.jumpToPage(
                      page: liquidController.currentPage + 1 >
                              controller.pages.length - 1
                          ? 0
                          : liquidController.currentPage + 1);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.01),
                    foregroundColor: Colors.black),
                child: liquidController.currentPage + 1 ==
                        controller.pages.length
                    ? const SizedBox.shrink()
                    : const Text("Next", style: TextStyle(color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }

  // build dot
  Widget _buildDot(int index) {
    double selectedNess = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.currentPageIndex) - index).abs(),
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
