import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/message/controller.dart';
import '../../common/style/color.dart';
import '../../generated/assets.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  Widget _headBar() => Container(
        width: 320.w,
        height: 44.h,
        margin: EdgeInsets.symmetric(vertical: 20.h),
        child: Row(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () => controller.navigateToProfile(),
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: controller.state.userDetails.value.avatar == null
                          ? const DecorationImage(
                              image: AssetImage(Assets.imagesDefault),
                            )
                          : DecorationImage(
                              image: NetworkImage(
                                controller.state.userDetails.value.avatar!,
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
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.accentColorLite,
        onPressed: null,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(Assets.iconsContact),
        )
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: _headBar(),
          )
        ],
      ),
    );
  }
}
