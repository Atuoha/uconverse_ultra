import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../style/color.dart';
import '../../pages/frames/splash/controller.dart';

class SplashContainer extends GetView<SplashController> {
  final String title;
  final String subtitle;
  final String imageAsset;
  final Color backgroundColor;
  final Color textColor;
  final bool isLast;

  const SplashContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.backgroundColor,
    required this.textColor,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imageAsset, fit: BoxFit.cover),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    fontSize: 29,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                isLast
                    ? ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Start exploring',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => controller.launchApp(),
                      )
                    : const Text(''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
