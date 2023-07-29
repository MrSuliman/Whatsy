import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whatsy/core/helper/my_behavior.dart';
import 'package:whatsy/core/model/message_model.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';
import 'package:whatsy/features/chat/view/chat/widget/date_card.dart';
import 'package:whatsy/features/chat/view/chat/widget/msg_card.dart';
import 'package:whatsy/features/chat/view/chat/widget/yellow_card.dart';

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
  bool haveNip(int index, AsyncSnapshot<List<MsgModel>> snapshot) {
    if (index == snapshot.data!.length - 1 ||
        (snapshot.data![index].senderId !=
            snapshot.data![index + 1].senderId) ||
        (isHereDate(index, snapshot))) {
      return true;
    }
    return false;
  }

  bool isHereDate(int index, AsyncSnapshot<List<MsgModel>> snapshot) {
    if ((index == snapshot.data!.length - 1) ||
        (snapshot.data![index].timeSent.day >
            snapshot.data![index + 1].timeSent.day)) {
      return true;
    }
    return false;
  }

  String dateFormat(AsyncSnapshot<List<MsgModel>> snapshot, int index) {
    return (DateTime.now().day > snapshot.data![index].timeSent.day)
        ? (DateTime.now().day > snapshot.data![index].timeSent.day &&
                DateTime.now().day - snapshot.data![index].timeSent.day <= 1)
            ? 'Yesterday'
            : DateFormat.yMMMd().format(
                snapshot.data![index].timeSent,
              )
        : 'Today';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: StreamBuilder<List<MsgModel>>(
        stream: BlocProvider.of<ChatCubit>(context).fetchPaginatedMsgs(
          widget.userModel.id,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(); // ShimmerMsgs();
          } else if (snapshot.connectionState == ConnectionState.active) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: ListView.builder(
                controller: widget.scrollController,
                shrinkWrap: true,
                reverse: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      if (index == snapshot.data!.length - 1) const YellowCard(),
                      if (isHereDate(index, snapshot))
                        DateCard(dateFormat(snapshot, index)),
                      MsgCard(
                        snapshot.data![index],
                        haveNip(index, snapshot),
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('Error '),
            );
          }
        },
      ),
    );
  }
}
