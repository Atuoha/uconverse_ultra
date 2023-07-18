import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';
import '../../common/style/color.dart';
import '../../generated/assets.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.accentColorLite,
        onPressed: () => Get.defaultDialog(
          title: "Sign out",
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Are you sure you want to sign out?"),
          ),
          onConfirm: controller.signOut,
          onCancel: () => Navigator.pop(context),
          confirmTextColor: Colors.white,
        ),
        icon: const Icon(Icons.logout),
        label: const Text('Sign out'),
      ),
      appBar: _buildAppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfilePhoto(),
            const SizedBox(height: 10),
            Text(
              controller.state.userDetails.name ?? 'Unknown Name',
              style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 16.sp,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.accentColorLite,
                  padding: EdgeInsets.symmetric(horizontal: 35.w)),
              onPressed: () {},
              child: const Text('Sync profile details'),
            )
          ],
        ),
      ),
    );
  }

  // appbar
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (context) => GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.chevron_left,
            color: Colors.grey,
          ),
        ),
      ),
      actions: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              'Status',
              style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 10),
            Switch(
              activeTrackColor: AppColor.activeColor,
              inactiveTrackColor: AppColor.secondaryText,
              activeColor: Colors.white,
              value: controller.state.isOnline,
              onChanged: (value) {
                controller.toggleOnline(value: value);
              },
            )
          ],
        )
      ],
    );
  }

  // profile photo
  Widget _buildProfilePhoto() {
    return Stack(
      children: [
        Container(
          height: 150.h,
          width: 120.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: controller.state.userDetails.avatar == null
                ? const DecorationImage(
                    image: AssetImage(Assets.imagesDefault),
                  )
                : DecorationImage(
                    image: NetworkImage(
                      controller.state.userDetails.avatar!,
                    ),
                  ),
          ),
        ),
        Positioned(
          bottom: 15.h,
          right: 4.h,
          child: GestureDetector(
            onTap: null,
            child: Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                color: AppColor.accentColorLite,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                  child: Image.asset(
                    Assets.iconsAPhoto,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
