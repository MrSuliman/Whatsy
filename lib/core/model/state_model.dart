import 'package:equatable/equatable.dart';

class StateModel extends Equatable {
  const StateModel({
    required this.active,
    required this.lastSeen,
  });

  final bool active;
  final int lastSeen;

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      active: json["active"],
      lastSeen: json["lastSeen"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "active": active,
      "lastSeen": lastSeen,
    };
  }

  @override
  List<Object?> get props => [active, lastSeen];
}
