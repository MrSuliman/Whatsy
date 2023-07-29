import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class AvatarImg extends StatelessWidget {
  const AvatarImg({
    super.key,
    this.size,
    required this.imageUrl,
    this.radius,
  });

  final String imageUrl;
  final double? size;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 26,
      backgroundImage:
          imageUrl.isNotEmpty ? CachedNetworkImageProvider(imageUrl) : null,
      backgroundColor: context.theme.greyColor,
      child: imageUrl.isEmpty
          ? Icon(
              Icons.person,
              size: size ?? 30,
              color: Colors.white,
            )
          : null,
    );
  }
}
