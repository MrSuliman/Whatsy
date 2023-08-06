import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:whatsy/core/constant/message_type.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/message_model.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/widget/avatar_img.dart';
import 'package:whatsy/core/widget/custom_icon.dart';

class MsgTime extends StatelessWidget {
  const MsgTime(this.msgModel, this.userModel, {super.key});
  final MsgModel msgModel;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Msg(msgModel: msgModel, userModel: userModel),
        Positioned(
          right: msgModel.type != MessageType.text ? 2 : 0,
          bottom: 0,
          child: msgModel.type == MessageType.image
              ? Container(
                  padding: const EdgeInsets.only(top: 2, left: 2),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ],
                  ),
                  child: Date(msgModel: msgModel),
                )
              : Date(msgModel: msgModel),
        ),
      ],
    );
  }
}

class Date extends StatelessWidget {
  const Date({
    super.key,
    required this.msgModel,
  });

  final MsgModel msgModel;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat.Hm().format(msgModel.timeSent),
      style: msgModel.type == MessageType.image
          ? Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: Colors.white)
          : Theme.of(context).textTheme.labelSmall,
    );
  }
}

class Msg extends StatelessWidget {
  const Msg({super.key, required this.msgModel, this.userModel});
  final MsgModel msgModel;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    Duration duration = Duration.zero;
    Duration position = Duration.zero;

    return msgModel.type == MessageType.text
        ? Padding(
            padding: EdgeInsets.only(
              right: (msgModel.msg).length <= 35 ? 40 : 10,
            ),
            child: Text(
              '${msgModel.msg}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          )
        : msgModel.type == MessageType.audio
            ? AudioMsg(
                msgModel: msgModel,
                userModel: userModel!,
                audioPlayer: audioPlayer,
                isPlaying: isPlaying,
                duration: duration,
                position: position,
              )
            : msgModel.type == MessageType.video
                ? VideoMsg(msgModel: msgModel)
                : ImgMsg(msgModel: msgModel);
  }
}

class VideoMsg extends StatelessWidget {
  const VideoMsg({
    super.key,
    required this.msgModel,
  });

  final MsgModel msgModel;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          CachedVideoPlayer(msgModel.msg),
          CustomIcon(
            onPressed: () {},
            icon: Icons.play_arrow,
          )
        ],
      ),
    );
  }
}

class AudioMsg extends StatefulWidget {
  const AudioMsg({
    super.key,
    required this.userModel,
    required this.msgModel,
    required this.audioPlayer,
    required this.isPlaying,
    required this.duration,
    required this.position,
  });

  final MsgModel msgModel;
  final UserModel userModel;
  final bool isPlaying;
  final Duration duration;
  final Duration position;
  final AudioPlayer audioPlayer;

  @override
  State<AudioMsg> createState() => _AudioMsgState();
}

class _AudioMsgState extends State<AudioMsg> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      horizontalTitleGap: 5,
      dense: true,
      leading: GestureDetector(
        onTap: () {
          context.push(profile, extra: widget.userModel);
        },
        child: AvatarImg(
          radius: 22,
          imageUrl: widget.userModel.imageUrl,
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: CustomIcon(
              onPressed: () async {
                await widget.audioPlayer.play(UrlSource(widget.msgModel.msg));
              },
              icon: widget.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
          Expanded(
            flex: 8,
            child: Slider(
              onChanged: (val) {},
              min: 0,
              max: widget.duration.inSeconds.toDouble(),
              value: widget.position.inSeconds.toDouble(),
            ),
          ),
        ],
      ),
    );
  }
}

class ImgMsg extends StatelessWidget {
  const ImgMsg({
    super.key,
    required this.msgModel,
  });

  final MsgModel msgModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image(
        width: MediaQuery.of(context).size.width * 0.6,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
        image: CachedNetworkImageProvider(msgModel.msg),
      ),
    );
  }
}

class MyMsg {
  final DateTime _dateTime = DateTime.now();

  static MsgModel msgModel(
    FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot,
    int index,
  ) {
    return MsgModel.fromJson(snapshot.docs[index].data());
  }

  bool isHereDate(
    int index,
    FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot,
  ) {
    if (index == snapshot.docs.length - 1 ||
        msgModel(snapshot, index).timeSent.day >
            msgModel(snapshot, index + 1).timeSent.day) {
      return true;
    }
    return false;
  }

  bool haveNip(
    int index,
    FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot,
  ) {
    if (index == snapshot.docs.length - 1 ||
        (msgModel(snapshot, index).senderId !=
            (msgModel(snapshot, index + 1).senderId)) ||
        (isHereDate(index, snapshot))) {
      return true;
    }
    return false;
  }

  String dateFormat(
    FirestoreQueryBuilderSnapshot<Map<String, dynamic>> snapshot,
    int index,
  ) {
    if (_dateTime.day == msgModel(snapshot, index).timeSent.day &&
        _dateTime.month == msgModel(snapshot, index).timeSent.month) {
      return 'Today';
    }
    return DateFormat.yMMMd().format(MyMsg.msgModel(snapshot, index).timeSent);
  }
}
