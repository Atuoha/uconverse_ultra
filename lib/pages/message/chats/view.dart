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
      leading: Builder(
        builder: (context) => GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.chevron_left,
            color: Colors.grey,
          ),
        ),
      ),
      title: Obx(
        () => Text(
          controller.state.toName.value,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Avenir",
            fontWeight: FontWeight.bold,
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
                decoration: BoxDecoration(
                  color: controller.state.toOnline.value == "1"
                      ? AppColor.activeColor
                      : AppColor.secondaryText,
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
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: null,
                      child: Container(
                        height: 45.h,
                        width: 45.w,
                        decoration:  BoxDecoration(
                          color: AppColor.primaryColorLite,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      width: 295.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 228.w,
                            child: const TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Type a message",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                          Image.asset(
                            Assets.iconsSend,
                            width: 40.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
