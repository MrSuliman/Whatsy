import 'package:flutter/widgets.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/model/state_model.dart';

class AppObserver with WidgetsBindingObserver {
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
    if (Db.auth.currentUser != null) {
      await Db.realTime
          .ref(Db.infoConnected)
          .child(Db.currentUser.uid)
          .update(state.toJson());

      await Db.store
          .collection(Db.users)
          .doc(Db.auth.currentUser!.uid)
          .update(state.toJson());
    }
  }

  void offlineUser() async {
    final offline = StateModel(
      active: false,
      lastSeen: DateTime.now().millisecondsSinceEpoch,
    ).toJson();

    if (Db.auth.currentUser != null) {
      await Db.realTime
          .ref(Db.infoConnected)
          .child(Db.auth.currentUser!.uid)
          .onDisconnect()
          .update(offline);

      await Db.store
          .collection(Db.users)
          .doc(Db.auth.currentUser!.uid)
          .update(offline);
    }
  }
}
