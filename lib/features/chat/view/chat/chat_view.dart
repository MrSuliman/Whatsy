import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_app_bar.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_bg.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_input.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: chatAppBar(context, userModel),
        body: Stack(
          children: [
            const ChatBg(),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                const ChatInput(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
