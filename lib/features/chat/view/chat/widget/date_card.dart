import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class DateCard extends StatelessWidget {
  const DateCard(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: context.theme.reciverChatCardBg,
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
