import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/is_that_you.dart';
import 'package:whatsy/core/widget/avatar_img.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/core/utils/last_seen_format.dart';

AppBar chatAppBar(BuildContext context, UserModel userModel) {
  return AppBar(
    elevation: 0,
    titleSpacing: -4,
    title: InkWell(
      onTap: () => context.push(profile, extra: userModel),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: 'profile_img',
            child: AvatarImg(
              radius: 22,
              imageUrl: userModel.imageUrl,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${userModel.name} ${isThatYou(userModel.id, Db.currentUser.uid)}',
                softWrap: true,
                style: const TextStyle(color: Colors.white),
              ),
              Db.currentUser.uid != userModel.id
                  ? StreamBuilder(
                      stream: BlocProvider.of<AuthCubit>(context)
                          .getUserPresence(userModel.id),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState !=
                            ConnectionState.active) {
                          return const SizedBox();
                        } else {
                          return Text(
                            snapshot.data!.active
                                ? 'online'
                                : lastSeenFormat(snapshot.data!.lastSeen),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                          );
                        }
                      },
                    )
                  : Text(
                      'Message yourself',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.white.withOpacity(0.7),
                          ),
                    ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      // Db.currentUser.uid != userModel.id
      //     ? CustomIcon(
      //         onPressed: () {
      //           showMsgToUser(
      //             context: context,
      //             msg: 'Video calls are coming soon ...',
      //           );
      //         },
      //         icon: Icons.video_camera_front,
      //       )
      //     : const SizedBox(),
      // Db.currentUser.uid != userModel.id
      //     ? CustomIcon(
      //         onPressed: () {
      //           showMsgToUser(
      //             context: context,
      //             msg: 'Audio calls are coming soon ...',
      //           );
      //         },
      //         icon: Icons.add_ic_call,
      //       )
      //     : const SizedBox(),
      CustomIcon(
        onPressed: () {},
        icon: Icons.more_vert,
      ),
    ],
  );
}
