import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common/style/color.dart';
import '../../../../generated/assets.dart';
import 'controller.dart';

class VoiceCallPage extends GetView<VoiceCallController> {
  const VoiceCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColorLite,
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Obx(
          () => SafeArea(
            child: Center(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.state.toAvatar.value,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesDefault),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesDefault),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.state.toName.value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.state.isJoined.value ? '0:00' : 'Calling',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: 100,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CallActionWidget(
                              title: 'Speaker',
                              bgColor: controller.state.isSpeakerOn.value
                                  ? AppColor.primaryColorLite
                                  : Colors.white,
                              function: controller.toggleSpeaker,
                              img: controller.state.isSpeakerOn.value
                                  ? Assets.iconsAoTrumpet
                                  : Assets.iconsBoTrumpet,
                            ),
                            CallActionWidget(
                              title: 'Microphone',
                              bgColor: controller.state.isMicrophoneOn.value
                                  ? AppColor.primaryColorLite
                                  : Colors.white,
                              function: controller.toggleMicrophone,
                              img: controller.state.isMicrophoneOn.value
                                  ? Assets.iconsAMicrophone
                                  : Assets.iconsBMicrophone,
                            ),
                            CallActionWidget(
                              title: 'Disconnect',
                              bgColor: Colors.red.withOpacity(0.7),
                              function: () {},
                              img: Assets.iconsATelephone,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CallActionWidget extends StatelessWidget {
  const CallActionWidget({
    super.key,
    required this.title,
    required this.img,
    required this.function,
    required this.bgColor,
  });

  final String title;
  final String img;
  final Color bgColor;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: Column(
        children: [
          Container(
            height: 60.h,
            width: 60.h,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                img,
                width: 25.w,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: AppColor.primaryColorLite,
            ),
          )
        ],
      ),
    );
  }
}
