import 'package:equatable/equatable.dart';
import 'package:whatsy/core/constant/message_type.dart';

class MsgModel extends Equatable {
  const MsgModel({
    required this.msg,
    required this.type,
    required this.msgId,
    required this.timeSent,
    required this.isSeen,
    required this.senderId,
    required this.reciverId,
  });

  final String msg;
  final String msgId;
  final MessageType type;
  final DateTime timeSent;
  final String senderId;
  final String reciverId;
  final bool isSeen;

  factory MsgModel.fromJson(Map<String, dynamic> json) {
    return MsgModel(
      msg: json['message'],
      type: (json['type'] as String).toEnum(),
      msgId: json['message_id'],
      timeSent: DateTime.fromMillisecondsSinceEpoch(json['time_sent']),
      isSeen: json['is_seen'],
      senderId: json['sender_id'],
      reciverId: json['reciver_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': msg,
      'type': type.type,
      'is_seen': isSeen,
      'time_sent': timeSent.millisecondsSinceEpoch,
      'message_id': msgId,
      'sender_id': senderId,
      'reciver_id': reciverId,
    };
  }

  @override
  List<Object?> get props => [
        msg,
        type,
        isSeen,
        timeSent,
        msgId,
        senderId,
        reciverId,
      ];
}
