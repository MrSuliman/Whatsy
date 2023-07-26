import 'package:flutter/material.dart';

class AttachIconWithText extends StatelessWidget {
  const AttachIconWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
  });

  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
