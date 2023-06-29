import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/pages/message/controller.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Message Body'),
      ),
    );
  }
}
