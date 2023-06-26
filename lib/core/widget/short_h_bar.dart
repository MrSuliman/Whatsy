import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class ShortHBar extends StatelessWidget {
  const ShortHBar({
    Key? key,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  final double? width, height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50,
      height: height ?? 4,
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: color ?? context.theme.greyColor!.withOpacity(0.4),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
