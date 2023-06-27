import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uconverse_ultra/screens/entry.dart';

void main() {
  runApp(const UconverseApp());
}

class UconverseApp extends StatelessWidget {
  const UconverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: EntryScreen(),
      ),
    );
  }
}
