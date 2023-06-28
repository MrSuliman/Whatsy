import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/avatar_img.dart';

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
<<<<<<< HEAD
            userModel.name,
=======
            userModel?.name ?? 'Unknown',
>>>>>>> 68f6be85123405539f75d489f0aba4c5495807da
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            lastSeenFormat(userModel.lastSeen),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ).appBar(context),
    );
  }
}
