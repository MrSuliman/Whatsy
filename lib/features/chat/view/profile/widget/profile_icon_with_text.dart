import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';

class ProfileIconWithText extends StatelessWidget {
  const ProfileIconWithText({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Colory.greenLight,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colory.greenLight,
          ),
        ),
      ],
    );
  }
}
