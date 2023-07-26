import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String phone;
  final bool active;
  final int lastSeen;

  const UserModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.phone,
    required this.active,
    required this.lastSeen,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image_url": imageUrl,
      "phone": phone,
      "active": active,
      "last_seen": lastSeen,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      imageUrl: json["image_url"],
      phone: json["phone"],
      active: json["active"],
      lastSeen: json["last_seen"] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        phone,
        active,
        lastSeen,
      ];
}
