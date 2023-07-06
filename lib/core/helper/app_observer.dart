import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:whatsy/core/model/state_model.dart';

class AppObserver with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  final FirebaseDatabase _realTime = FirebaseDatabase.instance;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // App is in foreground
        onlineUser(
          StateModel(
            active: true,
            lastSeen: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        break;

      case AppLifecycleState.paused:
        // App is in background
        onlineUser(
          StateModel(
            active: false,
            lastSeen: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        break;

      default:
        break;
    }
  }

  void onlineUser(StateModel state) async {
    if (_auth.currentUser != null) {
      await _realTime
          .ref('info/connected')
          .child(_auth.currentUser!.uid)
          .update(state.toJson());

      await _store
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(state.toJson());
    }
  }

  void offlineUser() async {
    final offline = StateModel(
      active: false,
      lastSeen: DateTime.now().millisecondsSinceEpoch,
    ).toJson();

    if (_auth.currentUser != null) {
      await _realTime
          .ref('info/connected')
          .child(_auth.currentUser!.uid)
          .onDisconnect()
          .update(offline);

      await _store
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(offline);
    }
  }
}
