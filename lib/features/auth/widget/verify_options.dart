import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class VerifyOptions extends StatelessWidget {
  const VerifyOptions({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: context.theme.greyColor),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: context.theme.greyColor),
          ),
        ],
      ),
    );
  }
}
