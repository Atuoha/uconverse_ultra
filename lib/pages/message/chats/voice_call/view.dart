import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/message/chats/voice_call/widgets/call_widgets.dart';
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
                    controller.state.callTime.value,
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
                            // Speaker
                            CallActionWidget(
                              title: 'Speaker',
                              bgColor: controller.state.isSpeakerOn.value
                                  ? Colors.white
                                  : AppColor.primaryColorLite,
                              function: controller.toggleSpeaker,
                              img: controller.state.isSpeakerOn.value
                                  ? Assets.iconsBoTrumpet
                                  : Assets.iconsATrumpet,
                            ),

                            // Microphone
                            CallActionWidget(
                              title: 'Microphone',
                              bgColor: controller.state.isMicrophoneOn.value
                                  ? Colors.white
                                  : AppColor.primaryColorLite,
                              function: controller.toggleMicrophone,
                              img: controller.state.isMicrophoneOn.value
                                  ? Assets.iconsBMicrophone
                                  : Assets.iconsAMicrophone,
                            ),

                            // Disconnect
                            CallActionWidget(
                              title: controller.state.isJoined.value
                                  ? 'Disconnect'
                                  : 'Connecting',
                              bgColor: controller.state.isJoined.value
                                  ? Colors.red.withOpacity(0.7)
                                  : Colors.green.withOpacity(0.7),
                              function: controller.state.isJoined.value? controller.leaveChannel:controller.joinChannel,
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
