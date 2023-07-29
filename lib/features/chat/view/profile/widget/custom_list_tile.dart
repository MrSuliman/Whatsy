import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
  });

  final Icon? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.fromLTRB(25, 5, 10, 5),
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.normal,
            ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: context.theme.greyColor,
              ),
            )
          : null,
      trailing: trailing,
    );
  }
}
