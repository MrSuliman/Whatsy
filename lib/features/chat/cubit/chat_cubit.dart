import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/constant/message_type.dart';
import 'package:whatsy/core/model/last_message.dart';
import 'package:whatsy/core/model/message_model.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/store_file.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  // ! not used yet, until doing ui first.
  Future<void> deleteMsg(String receiverId, String msgId) async {
    // ! delete msg from sender
    await Db.store
        .collection(Db.users)
        .doc(Db.auth.currentUser!.uid)
        .collection(Db.chats)
        .doc(receiverId)
        .collection(Db.chats)
        .doc(msgId)
        .delete();

    // ! delete msg from receiver
    await Db.store
        .collection(Db.users)
        .doc(receiverId)
        .collection(Db.chats)
        .doc(Db.auth.currentUser!.uid)
        .collection(Db.chats)
        .doc(msgId)
        .delete();
  }

  Future<void> sendFile({
    required MessageType msgType,
    UserModel? senderData,
    required String receiverId,
    required dynamic file,
  }) async {
    String lastMsg;
    final msgId = const Uuid().v1();
    final DateTime timeSent = DateTime.now();
    String storeMedia = await storeFileToStorage(
      file: file,
      path: '${Db.media}/${msgType.type}/${senderData!.id}/$receiverId/$msgId',
    );
    final UserModel receiverData = await Db.store
        .collection(Db.users)
        .doc(receiverId)
        .get()
        .then((value) => UserModel.fromJson(value.data()!));

    switch (msgType) {
      case MessageType.image:
        lastMsg = '📸 Photo';
        break;
      case MessageType.audio:
        lastMsg = '🎤 Audio';
        break;
      case MessageType.video:
        lastMsg = '📸 Video';
        break;
      case MessageType.gif:
        lastMsg = '📸 GIF';
        break;
      default:
        lastMsg = 'GIF message';
    }

    _saveMsg(
      msg: storeMedia,
      type: msgType,
      msgId: msgId,
      timeSent: timeSent,
      senderId: senderData.id,
      reciverId: receiverId,
      senderName: senderData.name,
      reciverName: receiverData.name,
    );

    _saveLastMsg(
      senderData: senderData,
      reciverData: receiverData,
      reciverId: receiverData.id,
      timeSent: timeSent,
      lastMsg: lastMsg,
    );
  }

  // ! not used any more
  // Stream<List<MsgModel>> fetchPaginatedMsgs(String receiverId) {
  //   final collectionReference = Db.store
  //       .collection(Db.users)
  //       .doc(Db.currentUser.uid)
  //       .collection(Db.chats)
  //       .doc(receiverId)
  //       .collection(Db.messages);

  //   var query = collectionReference.orderBy('time_sent', descending: true);

  //   return query.snapshots().map((event) {
  //     List<MsgModel> messages = [];
  //     for (var msg in event.docs) {
  //       messages.add(MsgModel.fromJson(msg.data()));
  //     }
  //     return messages;
  //   });
  // }

  Stream<List<LastMsgModel>> fetchLastMsg() {
    return Db.store
        .collection(Db.users)
        .doc(Db.currentUser.uid)
        .collection(Db.chats)
        .snapshots()
        .asyncMap((event) async {
      List<LastMsgModel> contacts = [];
      for (var doc in event.docs) {
        final LastMsgModel lastMsg = LastMsgModel.fromJson(doc.data());
        final userData =
            await Db.store.collection(Db.users).doc(lastMsg.contactId).get();
        final user = UserModel.fromJson(userData.data()!);
        contacts.add(
          LastMsgModel(
            name: user.name,
            imageUrl: user.imageUrl,
            contactId: lastMsg.contactId,
            timeSent: lastMsg.timeSent,
            lastMsg: lastMsg.lastMsg,
          ),
        );
      }
      return contacts;
    });
  }

  Future<void> sendMsg({
    required String msg,
    required String reciverId,
    required UserModel? senderData,
    required MessageType msgType,
  }) async {
    try {
      final msgId = const Uuid().v1();
      final DateTime timeSent = DateTime.now();
      final reciverMap =
          await Db.store.collection(Db.users).doc(reciverId).get();
      final reciverData = UserModel.fromJson(reciverMap.data()!);

      _saveMsg(
        msg: msg,
        msgId: msgId,
        timeSent: timeSent,
        type: msgType,
        senderId: senderData!.id,
        reciverId: reciverId,
        senderName: senderData.name,
        reciverName: reciverData.name,
      );

      _saveLastMsg(
        lastMsg: msg,
        timeSent: timeSent,
        reciverId: reciverId,
        senderData: senderData,
        reciverData: reciverData,
      );
    } catch (e) {
      emit(ChatError(e.toString()));
      emit(ChatInitial());
    }
  }

  Future<void> _saveMsg({
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
      senderId: Db.currentUser.uid,
      reciverId: reciverId,
    );

    // * Sender
    await Db.store
        .collection(Db.users)
        .doc(Db.currentUser.uid)
        .collection(Db.chats)
        .doc(reciverId)
        .collection(Db.messages)
        .doc(msgId)
        .set(message.toJson());

    // * Reciver
    await Db.store
        .collection(Db.users)
        .doc(reciverId)
        .collection(Db.chats)
        .doc(Db.currentUser.uid)
        .collection(Db.messages)
        .doc(msgId)
        .set(message.toJson());
  }

  Future<void> _saveLastMsg({
    required UserModel senderData,
    required UserModel reciverData,
    required String reciverId,
    required DateTime timeSent,
    required String lastMsg,
  }) async {
    // * Sender
    final LastMsgModel senderLastMsg = LastMsgModel(
      contactId: reciverData.id,
      name: reciverData.name,
      imageUrl: reciverData.imageUrl,
      timeSent: timeSent,
      lastMsg: lastMsg,
    );

    await Db.store
        .collection(Db.users)
        .doc(Db.currentUser.uid)
        .collection(Db.chats)
        .doc(reciverId)
        .set(senderLastMsg.toJson());

    // * Reciver
    final LastMsgModel reciverLastMsg = LastMsgModel(
      contactId: senderData.id,
      name: senderData.name,
      imageUrl: senderData.imageUrl,
      timeSent: timeSent,
      lastMsg: lastMsg,
    );

    await Db.store
        .collection(Db.users)
        .doc(reciverId)
        .collection(Db.chats)
        .doc(Db.currentUser.uid)
        .set(reciverLastMsg.toJson());
  }
}



