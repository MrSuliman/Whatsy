import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/avatar_img.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, this.userModel});

  final UserModel? userModel;

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
            backgroundImage: userModel!.imageUrl.isNotEmpty
                ? CachedNetworkImageProvider(userModel!.imageUrl)
                : null,
          ),
          title: Text(
            userModel?.name ?? 'Unknownssss',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            '${userModel?.lastSeen}' ?? '',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ).appBar(context),
    );
  }
}
