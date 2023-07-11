import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller.dart';
import '../../common/style/color.dart';
import '../../generated/assets.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Text('cONTACTS'),
      ),
    );
  }
}

// appbar
AppBar _buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    title: const Text(
      'Contacts',
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),
    leading: Builder(
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.grey,
        ),
      ),
    ),
  );
}
