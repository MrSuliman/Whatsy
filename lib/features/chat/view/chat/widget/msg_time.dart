import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatsy/core/model/message_model.dart';

class MsgTime extends StatelessWidget {
  const MsgTime(this.msgModel, this.right, this.rightPadding, {super.key});

  final MsgModel msgModel;
  final double right;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 12, right: rightPadding),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.78,
          ),
          child: Text(
            msgModel.msg,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        Positioned(
          right: right,
          bottom: 0,
          child: Text(
            DateFormat.Hm().format(msgModel.timeSent).toString(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}
