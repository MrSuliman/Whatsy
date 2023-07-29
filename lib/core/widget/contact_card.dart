import 'package:flutter/material.dart';
import 'package:whatsy/core/widget/avatar_img.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    required this.userImg,
    this.trailing,
  });

  final Widget title;
  final String? subtitle;
  final void Function()? onTap;
  final String userImg;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: AvatarImg(
        size: 30,
        radius: 28,
        imageUrl: userImg,
      ),
      title: title,
      subtitle: subtitle != null
          ? Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}
