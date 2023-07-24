import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../common/style/color.dart';

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