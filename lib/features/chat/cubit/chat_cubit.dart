import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/model/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  // final FirebaseDatabase _realTime = FirebaseDatabase.instance;

  Stream<UserModel> getUserStatus({required String id}) {
    return _store
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }

  // Future<void> updateUserStatus() async {
  //   final Map<String, dynamic> online = StateModel(
  //     active: true,
  //     lastSeen: DateTime.now().millisecondsSinceEpoch,
  //   ).toJson();
  //
  //   final Map<String, dynamic> offline = StateModel(
  //     active: false,
  //     lastSeen: DateTime.now().millisecondsSinceEpoch,
  //   ).toJson();
  //
  //   final connectedRef = _realTime.ref();
  //
  //   try {
  //     connectedRef.onValue.listen(
  //       (event) async {
  //         final isConnected = event.snapshot.value;
  //         if (isConnected == true) {
  //           await connectedRef
  //               .child(_auth.currentUser!.uid)
  //               .update(online)
  //               .then(
  //                 (_) => _store
  //                     .collection('users')
  //                     .doc(_auth.currentUser!.uid)
  //                     .update(online),
  //               );
  //         } else {
  //           await connectedRef
  //               .child(_auth.currentUser!.uid)
  //               .update(offline)
  //               .then(
  //                 (_) => _store
  //                     .collection('users')
  //                     .doc(_auth.currentUser!.uid)
  //                     .update(offline),
  //               );
  //         }
  //       },
  //     );
  //     emit(StateUpdated());
  //   } catch (e) {
  //     emit(StateError(e.toString()));
  //   }
  // }
}
