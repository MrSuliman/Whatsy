import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class BlockReport extends StatelessWidget {
  const BlockReport({
    super.key,
    required this.leading,
    required this.title,
  });

  final IconData leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.fromLTRB(25, 5, 10, 5),
      leading: Icon(
        leading,
        color: context.theme.blockReportColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: context.theme.blockReportColor,
        ),
      ),
    );
  }
}
