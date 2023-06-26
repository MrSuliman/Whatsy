import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    this.title,
    this.onTap,
    this.icon,
    this.iconBg,
    this.iconBtn,
    this.iconColor,
  });

  final String? title;
  final void Function()? onTap;
  final IconData? icon, iconBtn;
  final Color? iconBg, iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: CircleAvatar(
        backgroundColor: iconBg ?? Colory.greyLight.withOpacity(0.3),
        child: Icon(
          icon ?? Icons.person,
          size: 26,
          color: iconColor,
        ),
      ),
      title: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          iconBtn,
          color: Colory.greyLight,
        ),
      ),
    );
  }
}
