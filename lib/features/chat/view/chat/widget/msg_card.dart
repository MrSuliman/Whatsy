import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/model/message_model.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/features/chat/view/chat/widget/msg_time.dart';

class MsgCard extends StatelessWidget {
  const MsgCard(this.msgModel, this.haveNip, {super.key});

  final MsgModel msgModel;
  final bool haveNip;

  @override
  Widget build(BuildContext context) {
    final bool isMe = Db.currentUser.uid == msgModel.senderId;

    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        left: (!isMe && haveNip) ? 5 : 15,
        right: (isMe && haveNip) ? 5 : 15,
        bottom: 4,
      ),
      child: ClipPath(
        clipper: haveNip
            ? UpperNipMessageClipperTwo(
                isMe ? MessageType.send : MessageType.receive,
                nipWidth: 10,
                nipHeight: 10,
                bubbleRadius: 12,
              )
            : null,
        child: Container(
          padding: EdgeInsets.only(
            top: 8,
            bottom: 8,
            left: isMe ? 10 : 15,
            right: isMe ? 15 : 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isMe
                ? context.theme.senderChatCardBg
                : context.theme.reciverChatCardBg,
            boxShadow: const [
              BoxShadow(color: Colors.black38),
            ],
          ),
          child: MsgTime(
            msgModel,
            haveNip ? 10 : 0,
            haveNip ? 50 : 40,
          ),
        ),
      ),
    );
  }
}
