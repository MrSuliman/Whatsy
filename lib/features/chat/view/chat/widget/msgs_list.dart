import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/features/chat/view/chat/widget/date_card.dart';
import 'package:whatsy/features/chat/view/chat/widget/msg_card.dart';
import 'package:whatsy/features/chat/view/chat/widget/msg_time.dart';

// final PageStorageBucket _pageStorageBucket = PageStorageBucket();

class MsgsList extends StatefulWidget {
  const MsgsList({
    required this.scrollController,
    required this.userModel,
    super.key,
  });

  final UserModel userModel;
  final ScrollController scrollController;

  @override
  State<MsgsList> createState() => _MsgsListState();
}

class _MsgsListState extends State<MsgsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 58),
      child: FirestoreQueryBuilder(
        query: Db.store
            .collection(Db.users)
            .doc(Db.auth.currentUser!.uid)
            .collection(Db.chats)
            .doc(widget.userModel.id)
            .collection(Db.messages)
            .orderBy('time_sent', descending: true),
        builder: (context, snapshot, _) {
          return ListView.builder(
            controller: widget.scrollController,
            reverse: true,
            shrinkWrap: true,
            itemCount: snapshot.docs.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, int index) {
              if (snapshot.hasMore && (index == snapshot.docs.length - 1)) {
                snapshot.fetchMore();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (MyMsg().isHereDate(index, snapshot)) ...[
                    DateCard(MyMsg().dateFormat(snapshot, index))
                  ],
                  MsgCard(
                    MyMsg.msgModel(snapshot, index),
                    widget.userModel,
                    MyMsg().haveNip(index, snapshot),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
