import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/chat/chat_utils/last_seen_format.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 42,
        title: GestureDetector(
          onTap: () => context.push('/info', extra: userModel),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: userModel.imageUrl.isNotEmpty
                    ? CachedNetworkImageProvider(userModel.imageUrl)
                    : null,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    ),
                  ),
                  const SizedBox(height: 3),
                  StreamBuilder(
                    stream: BlocProvider.of<AuthCubit>(context)
                        .getUserPresence(userModel.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.active) {
                        return const SizedBox();
                      } else {
                        return Text(
                          snapshot.data!.active
                              ? 'online'
                              : lastSeenFormat(userModel.lastSeen),
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          CustomIcon(
            onPressed: () {
              showMsgToUser(
                context: context,
                msg: 'Video calls are comming soon ...',
              );
            },
            icon: Icons.video_camera_front,
          ),
          CustomIcon(
            onPressed: () {
              showMsgToUser(
                context: context,
                msg: 'Phone calls are comming soon ...',
              );
            },
            icon: Icons.add_ic_call,
          ),
          CustomIcon(
            onPressed: () {},
            icon: Icons.more_vert,
          ),
        ],
      ),
    );
  }
}
