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
      "imageUrl": imageUrl,
      "phone": phone,
      "active": active,
      "lastSeen": lastSeen,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      phone: json["phone"],
      active: json["active"],
      lastSeen: json["lastSeen"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        phone,
        active,
      ];
}
