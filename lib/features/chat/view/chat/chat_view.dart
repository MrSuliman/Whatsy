import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_app_bar.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_bg.dart';
import 'package:whatsy/features/chat/view/chat/widget/chat_input.dart';
import 'package:whatsy/features/chat/view/chat/widget/msgs_list.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  dynamic lasDoc;
  double containerHeight = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {}
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: context.theme.chatPageBg,
        appBar: chatAppBar(context, widget.userModel),
        body: Stack(
          children: [
            const ChatBg(),
            MsgsList(
              userModel: widget.userModel,
              scrollController: _scrollController,
            ),
            ChatInput(
              reciverId: widget.userModel.id,
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
