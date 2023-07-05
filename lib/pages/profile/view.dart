import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/profile/controller.dart';
import '../../common/style/color.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.chevron_left,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
