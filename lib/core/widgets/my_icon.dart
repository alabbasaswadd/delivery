import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MyIcon extends StatelessWidget {
  const MyIcon(
      {super.key,
      required this.icon,
      required this.left,
      required this.top,
      this.rotate = 0});
  final IconData icon;
  final double left;
  final double top;
  final double rotate;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: rotate,
        child: Icon(
          icon,
          size: 34,
          color: AppColor.kSecondColor,
        ),
      ),
    );
  }
}
