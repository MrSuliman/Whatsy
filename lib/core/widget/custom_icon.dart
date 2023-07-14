import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconSize,
    this.minWidth,
    this.background,
    this.border,
  }) : super(key: key);

  final IconData icon;
  final Function() onPressed;
  final Color? color;
  final double? iconSize;
  final double? minWidth;
  final Color? background;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: border,
      ),
      child: IconButton(
        onPressed: onPressed,
        iconSize: iconSize ?? 22,
        splashRadius: (minWidth ?? 40) - 25,
        padding: EdgeInsets.zero,
        splashColor: Colors.transparent,
        constraints: BoxConstraints(
          minWidth: minWidth ?? 40,
          minHeight: minWidth ?? 40,
        ),
        icon: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}
