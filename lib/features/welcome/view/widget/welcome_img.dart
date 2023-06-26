import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class WelcomeImg extends StatelessWidget {
  const WelcomeImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 10),
        child: Image.asset(
          "assets/images/circle.png",
          color: context.theme.circleImgColor,
        ),
      ),
    );
  }
}
