import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsy/core/widget/avatar_img.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
    this.textBtn,
    this.icon,
    this.iconBg,
    required this.userImg,
    this.onPressed,
  });

  final String? title, subtitle, textBtn;
  final void Function()? onTap;
  final void Function()? onPressed;
  final IconData? icon;
  final Color? iconBg;
  final String userImg;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: AvatarImg(
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
      trailing: TextButton(
        onPressed: onPressed,
        child: Text(textBtn ?? ''),
      ),
    );
  }
}
