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

  factory LastMsgModel.fromJson(Map<String, dynamic> json) {
    return LastMsgModel(
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      contactId: json['contact_id'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(json['time_sent']),
      lastMsg: json['last_message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
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
