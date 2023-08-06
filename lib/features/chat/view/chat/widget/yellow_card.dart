import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class YellowCard extends StatelessWidget {
  const YellowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(34, 8, 34, 8),
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
      decoration: BoxDecoration(
        color: context.theme.yellowCardBgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0.0, 0.75),
          ),
        ],
      ),
      child: Flexible(
        flex: 1,
        child: Text(
          '🔒  Messages and calls are end-to-end encrypted. No one outside of this chat, Not even Whatsy can read or listen to them, Tap to learn more.',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: context.theme.yellowCardTextColor),
        ),
      ),
    );
  }
}
