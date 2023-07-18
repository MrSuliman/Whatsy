import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsy/core/constant/message_type.dart';
import 'package:whatsy/core/model/last_message.dart';
import 'package:whatsy/core/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsy/core/model/user_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Future<void> sendMsg({
    required String msg,
    required String reciverId,
    required UserModel? senderData,
  }) async {
    try {
      final msgId = const Uuid().v1();
      final DateTime timeSent = DateTime.now();
      final reciverMap = await _store.collection('users').doc(reciverId).get();
      final reciverData = UserModel.fromJson(reciverMap.data()!);

      saveMsg(
        msg: msg,
        msgId: msgId,
        timeSent: timeSent,
        type: MessageType.text,
        senderId: senderData!.id,
        reciverId: reciverId,
        senderName: senderData.name,
        reciverName: reciverData.name,
      );

      saveLastMsg(
        lastMsg: msg,
        timeSent: timeSent,
        reciverId: reciverId,
        senderData: senderData,
        reciverData: reciverData,
      );
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> saveMsg({
    required String msg,
    required MessageType type,
    required String msgId,
    required DateTime timeSent,
    required String senderId,
    required String reciverId,
    required String senderName,
    required String reciverName,
  }) async {
    final MsgModel message = MsgModel(
      msg: msg,
      type: type,
      msgId: msgId,
      timeSent: timeSent,
      isSeen: false,
      senderId: _auth.currentUser!.uid,
      reciverId: reciverId,
    );

    try {
      // * Sender
      await _store
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('chat')
          .doc(reciverId)
          .collection('message')
          .doc(msgId)
          .set(message.toJson());

      // * Reciver
      await _store
          .collection('users')
          .doc(reciverId)
          .collection('chat')
          .doc(_auth.currentUser!.uid)
          .collection('message')
          .doc(msgId)
          .set(message.toJson());
    } catch (e) {
      emit(ChatError(e.toString()));
      emit(ChatInitial());
    }
  }

  Future<void> saveLastMsg({
    required UserModel senderData,
    required UserModel reciverData,
    required String reciverId,
    required DateTime timeSent,
    required String lastMsg,
  }) async {
    try {
      // * Sender
      final LastMsgModel senderLastMsg = LastMsgModel(
        contactId: reciverData.id,
        name: reciverData.name,
        imageUrl: reciverData.imageUrl,
        timeSent: timeSent,
        lastMsg: lastMsg,
      );

      await _store
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('chat')
          .doc(reciverId)
          .set(senderLastMsg.toMap());

      // * Reciver
      final LastMsgModel reciverLastMsg = LastMsgModel(
        contactId: senderData.id,
        name: senderData.name,
        imageUrl: senderData.imageUrl,
        timeSent: timeSent,
        lastMsg: lastMsg,
      );

      await _store
          .collection('users')
          .doc(reciverId)
          .collection('chat')
          .doc(_auth.currentUser!.uid)
          .set(reciverLastMsg.toMap());
    } catch (e) {
      emit(ChatError(e.toString()));
      emit(ChatInitial());
    }
  }

  // Stream<UserModel> getUserStatus({required String id}) {
  //   return _store
  //       .collection('users')
  //       .doc(id)
  //       .snapshots()
  //       .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  // }
}
