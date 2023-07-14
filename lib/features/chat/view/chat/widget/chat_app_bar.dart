import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/is_that_you.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/chat/chat_utils/last_seen_format.dart';

AppBar chatAppBar(BuildContext context, UserModel userModel) {
  return AppBar(
    elevation: 0,
    titleSpacing: 0,
    leadingWidth: 35,
    title: InkWell(
      onTap: () => context.push('/info', extra: userModel),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: 'profile_img',
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(userModel.imageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${userModel.name} ${isThatYou(userModel.id, FirebaseAuth.instance.currentUser!.uid)}',
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              const SizedBox(height: 3),
              FirebaseAuth.instance.currentUser!.uid != userModel.id
                  ? StreamBuilder(
                      stream: BlocProvider.of<AuthCubit>(context)
                          .getUserPresence(userModel.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState !=
                            ConnectionState.active) {
                          return const SizedBox();
                        } else {
                          return Text(
                            snapshot.data!.active
                                ? 'online'
                                : lastSeenFormat(userModel.lastSeen),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  overflow: TextOverflow.ellipsis,
                                ),
                          );
                        }
                      },
                    )
                  : Text(
                      'Message yourself',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      FirebaseAuth.instance.currentUser!.uid != userModel.id
          ? CustomIcon(
              onPressed: () {
                showMsgToUser(
                  context: context,
                  msg: 'Video calls are coming soon ...',
                );
              },
              icon: Icons.video_camera_front,
            )
          : const SizedBox(),
      FirebaseAuth.instance.currentUser!.uid != userModel.id
          ? CustomIcon(
              onPressed: () {
                showMsgToUser(
                  context: context,
                  msg: 'Audio calls are coming soon ...',
                );
              },
              icon: Icons.add_ic_call,
            )
          : const SizedBox(),
      CustomIcon(
        onPressed: () {},
        icon: Icons.more_vert,
      ),
    ],
  );
}
