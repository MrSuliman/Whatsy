import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class ChatBg extends StatelessWidget {
  const ChatBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.cover,
      width: double.maxFinite,
      height: double.maxFinite,
      color: context.theme.chatDoodleBg,
      image: const AssetImage('assets/images/doodle_bg.png'),
    );
  }
}
