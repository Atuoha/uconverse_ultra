import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uconverse_ultra/generated/assets.dart';
import 'package:uconverse_ultra/screens/splash_screen.dart';
import '../constants/colors.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.imagesUconverse, width: 150),
            const SizedBox(height: 10),
            const Text(
              'Uconverse',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: primaryColor,
                fontSize: 29,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '...conversing without limits',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: primaryColor,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
