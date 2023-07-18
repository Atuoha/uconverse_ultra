import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common/style/color.dart';
import '../../../generated/assets.dart';
import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  // build app bar
  AppBar _buildApp() {
    return AppBar(
      title: Obx(
        () => Text(
          controller.state.toName.value,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        Stack(
          children: [
            GestureDetector(
              onTap: () => {},
              child: CachedNetworkImage(
                imageUrl: controller.state.toAvatar.value,
                imageBuilder: (context, imageProvider) => Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesDefault),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(Assets.imagesDefault),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8.h,
              right: 6.h,
              child: Container(
                width: 10.w,
                height: 10.h,
                decoration: const BoxDecoration(
                  color: AppColor.activeColor,
                  shape: BoxShape.circle,
                ),
              ),
            )
          ],
        ),
        const SizedBox(width: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildApp(),
      body: const Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}
