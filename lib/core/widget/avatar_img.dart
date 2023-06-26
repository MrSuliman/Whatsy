import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';

class AvatarImg extends StatelessWidget {
  const AvatarImg({
    super.key,
    this.size,
    this.backgroundColor,
    this.backgroundImage,
    this.onTap,
  });

  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final double? size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundImage: backgroundImage,
        backgroundColor: backgroundColor ?? Colory.greyLight.withOpacity(0.3),
        child: backgroundImage == null
            ? Icon(
                Icons.person,
                size: size ?? 30,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
