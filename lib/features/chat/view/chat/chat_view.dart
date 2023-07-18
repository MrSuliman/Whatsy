import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_app_bar.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_bg.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_input.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: chatAppBar(context, widget.userModel),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            const ChatBg(),
            Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                Form(
                  key: _formKey,
                  child: ChatInput(
                    reciverId: widget.userModel.id,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
