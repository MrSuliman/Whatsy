import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _realTime = FirebaseDatabase.instance;

  Future<void> updateUserPresence() async {
    Map<String, dynamic> online = {
      'active': true,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    };
    Map<String, dynamic> offline = {
      'active': false,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    };

    final connectedRef = _realTime.ref('info/connected');

    connectedRef.onValue.listen(
      (event) async {
        final isConnected = event.snapshot.value as bool? ?? false;
        if (isConnected) {
          await _realTime.ref().child(_auth.currentUser!.uid).update(online);
        } else {
          await _realTime
              .ref()
              .child(_auth.currentUser!.uid)
              .onDisconnect()
              .update(offline);
        }
      },
    );
  }
}
