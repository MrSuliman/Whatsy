import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/constant/message_type.dart';
import 'package:whatsy/core/model/message_model.dart';
import 'package:custom_clippers/custom_clippers.dart' as clipper;
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/features/chat/view/chat/widget/msg_time.dart';

class MsgCard extends StatelessWidget {
  const MsgCard(this.msgModel, this.userModel, this.haveNip, {super.key});

  final MsgModel msgModel;
  final UserModel? userModel;
  final bool haveNip;

  @override
  Widget build(BuildContext context) {
    final bool isMe = Db.currentUser.uid == msgModel.senderId;

    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        left: (!isMe && haveNip) ? 0 : 10,
        right: (isMe && haveNip) ? 0 : 10,
        bottom: 4,
      ),
      child: ClipPath(
        clipper: clipper.UpperNipMessageClipperTwo(
          isMe ? clipper.MessageType.send : clipper.MessageType.receive,
          nipWidth: haveNip ? 10 : 0,
          nipHeight: haveNip ? 10 : 0,
          bubbleRadius: 10,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
            maxHeight: msgModel.type == MessageType.image
                ? MediaQuery.of(context).size.height * 0.35
                : double.infinity,
            minWidth: haveNip
                ? MediaQuery.of(context).size.width * 0.23
                : MediaQuery.of(context).size.width * 0.2,
          ),
          padding: msgModel.type == MessageType.image
              ? EdgeInsets.fromLTRB(3, 3, haveNip ? 13 : 3, 3)
              : EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: !isMe
                      ? haveNip
                          ? 15
                          : 5
                      : 5,
                  right: isMe
                      ? haveNip
                          ? 15
                          : 5
                      : 5,
                ),
          decoration: BoxDecoration(
            color: isMe
                ? context.theme.senderChatCardBg
                : context.theme.receiverChatCardBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: MsgTime(msgModel, userModel),
        ),
      ),
    );
  }
}
