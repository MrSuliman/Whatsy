import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/avatar_img.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userModel});

  final UserModel userModel;

  String lastSeenFormat(lastSeen) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(
      DateTime.fromMicrosecondsSinceEpoch(lastSeen),
    );

    String finalMsg = difference.inSeconds > 59
        ? difference.inMinutes > 59
            ? difference.inDays > 23
                ? "${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'}"
                : "${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'}"
            : "${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'}"
        : "few moments";

    return finalMsg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        title: ListTile(
          horizontalTitleGap: 10,
          contentPadding: EdgeInsets.zero,
          leading: AvatarImg(
            onTap: () {},
            backgroundImage: userModel.imageUrl.isNotEmpty
                ? CachedNetworkImageProvider(userModel.imageUrl)
                : null,
          ),
          title: Text(
            userModel.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          // subtitle: StreamBuilder<UserModel>(
          //     stream: BlocProvider.of<ChatCubit>(context).getUserStatus(
          //       id: userModel.id,
          //     ),
          //     builder: (context, snapshot) {
          //       return Text(
          //         lastSeenFormat(userModel.lastSeen),
          //         style: Theme.of(context).textTheme.labelLarge,
          //       );
          //     }),
        ),
      ).appBar(context),
    );
  }
}
