import 'package:equatable/equatable.dart';

class LastMsgModel extends Equatable {
  const LastMsgModel({
    required this.name,
    required this.imageUrl,
    required this.contactId,
    required this.timeSent,
    required this.lastMsg,
  });

  final String name;
  final String imageUrl;
  final String contactId;
  final DateTime timeSent;
  final String lastMsg;

  factory LastMsgModel.fromMap(Map<String, dynamic> map) {
    return LastMsgModel(
      name: map['name'] ?? '',
      imageUrl: map['image_url'] ?? '',
      contactId: map['contact_id'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['time_sent']),
      lastMsg: map['last_message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image_url': imageUrl,
      'contact_id': contactId,
      'time_sent': timeSent.millisecondsSinceEpoch,
      'last_message': lastMsg,
    };
  }

  @override
  List<Object?> get props => [
        name,
        imageUrl,
        contactId,
        timeSent,
        lastMsg,
      ];
}
