import 'package:flutter/material.dart';
import 'package:whatsy/core/widget/avatar_img.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
    this.icon,
    this.iconBg,
    required this.userImg,
    this.trailing,
  });

  final String? title, subtitle;
  final void Function()? onTap;
  final IconData? icon;
  final Color? iconBg;
  final String userImg;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: AvatarImg(
        radius: 28,
        backgroundColor: iconBg,
        backgroundImage:
            userImg.isNotEmpty ? CachedNetworkImageProvider(userImg) : null,
        size: 30,
      ),
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        subtitle ?? '',
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
    );
  }
}
