import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'widgets/attach_widget.dart';
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
        child: Obx(
          () => Stack(
            children: [
              Positioned(
                bottom: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => controller.toggleAttachmentBtnExpansion(),
                        child: Container(
                          height: 45.h,
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColorLite,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              controller.state.isAttachBtnExpanded.value
                                  ? Icons.cancel
                                  : Icons.add,
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
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.done,
                          maxLines: null,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () => print('hello'),
                              child: Image.asset(
                                Assets.iconsSend,
                                width: 40.w,
                              ),
                            ),
                            hintText: "Type a message",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                bottom: 70,
                height: 200.w,
                width: 300.w,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: controller.state.isAttachBtnExpanded.value ? 1 : 0,
                  child: Container(
                    height: 200.w,
                    width: 300.w,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.primaryColorLite,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10),
                      children: [
                        AttachWidget(
                          image: Assets.iconsPhoto,
                          title: 'Photo Gallery',
                          function: controller.photoGalleryHandler,
                        ),
                        AttachWidget(
                          image: Assets.iconsVoice,
                          title: 'Voice Record',
                          function: controller.voiceRecordHandler,
                        ),
                        AttachWidget(
                          image: Assets.iconsFile,
                          title: 'File Upload',
                          function: controller.fileHandler,
                        ),
                        AttachWidget(
                          image: Assets.iconsVideo,
                          title: 'Video Call',
                          function: controller.videoCallHandler,
                        ),
                        AttachWidget(
                          image: Assets.iconsCall,
                          title: 'Phone Call',
                          function: controller.phoneCallHandler,
                        ),
                        AttachWidget(
                          image: Assets.iconsLocation,
                          title: 'Location',
                          function: controller.locationHandler,
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
    );
  }
}
