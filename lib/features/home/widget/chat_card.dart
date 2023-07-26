import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/last_message.dart';
import 'package:intl/intl.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/is_that_you.dart';
import 'package:whatsy/core/widget/avatar_img.dart';
import 'package:whatsy/core/widget/custom_icon.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(this.lastMsgModel, {super.key});

  final LastMsgModel lastMsgModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.push(
          chat,
          extra: UserModel(
            id: lastMsgModel.contactId,
            name: lastMsgModel.name,
            imageUrl: lastMsgModel.imageUrl,
            phone: '',
            active: false,
            lastSeen: 0,
          ),
        );
      },
      dense: true,
      leading: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              iconPadding: EdgeInsets.zero,
              shape: const ContinuousRectangleBorder(),
              contentPadding: EdgeInsets.zero,
              icon: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.32,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(lastMsgModel.imageUrl),
                  ),
                ),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIcon(
                    onPressed: () {},
                    icon: Icons.message_rounded,
                    color: context.theme.greenColor,
                  ),
                  CustomIcon(
                    onPressed: () {},
                    icon: Icons.call_outlined,
                    color: context.theme.greenColor,
                  ),
                  CustomIcon(
                    onPressed: () {},
                    iconSize: 25,
                    icon: Icons.video_call_rounded,
                    color: context.theme.greenColor,
                  ),
                  CustomIcon(
                    onPressed: () {},
                    icon: Icons.info_outline,
                    color: context.theme.greenColor,
                  ),
                ],
              ),
            ),
          );
        },
        child: AvatarImg(
          radius: 28,
          backgroundImage: CachedNetworkImageProvider(lastMsgModel.imageUrl),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${lastMsgModel.name} ${isThatYou(lastMsgModel.contactId, Db.currentUser.uid)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            DateFormat.Hm().format(lastMsgModel.timeSent),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          lastMsgModel.lastMsg,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
    );
  }
}
