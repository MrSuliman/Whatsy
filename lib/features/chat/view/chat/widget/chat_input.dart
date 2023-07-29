import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/constant/message_type.dart';
import 'package:whatsy/core/helper/audio.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/scroll_down.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';
import 'package:whatsy/features/auth/view/gallery_view.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';
import 'package:whatsy/features/chat/view/chat/widget/attach_container.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.reciverId,
    required this.scrollController,
  });

  final String reciverId;
  final ScrollController scrollController;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  double cardHeight = 0;
  bool _isThereMsg = false;
  final _recorder = Audio();
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    _recorder.init();
    super.initState();
  }

  @override
  void dispose() {
    _recorder.dispose();
    _msgController.dispose();
    super.dispose();
  }

  void onChangeInput(String val) {
    setState(
      () {
        if (val.trim().isEmpty) {
          _isThereMsg = false;
        } else {
          _isThereMsg = true;
        }
      },
    );
  }

  Future _sendImgFromGallery() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider<PickImgCubit>(
            create: (context) => PickImgCubit(),
            child: const GalleryView(),
          ),
        )).then((value) {
      if (value != null) {
        _sendFileMsg(value, MessageType.image);
      }
      setState(() => cardHeight = 0);
    });
  }

  Future _sendFileMsg(file, msgType) async {
    await BlocProvider.of<ChatCubit>(context).sendFile(
      msgType: msgType,
      senderData:
          await BlocProvider.of<AuthCubit>(context).getCurrentUserInfo(),
      receiverId: widget.reciverId,
      file: file,
    );
    await scrollDown(widget);
  }

  Future<void> _sendTextMsg(BuildContext context) async {
    if (_isThereMsg) {
      await BlocProvider.of<ChatCubit>(context).sendMsg(
        msg: _msgController.text,
        reciverId: widget.reciverId,
        msgType: MessageType.text,
        senderData:
            await BlocProvider.of<AuthCubit>(context).getCurrentUserInfo(),
      );
      _msgController.clear();
      setState(() => _isThereMsg = false);
      await scrollDown(widget);
    } else if (!_isThereMsg) {
      await _recorder.permisson(context);
    }
  }

  void onPressAttachIcon(BuildContext context) {
    setState(() => cardHeight == 0
        ? cardHeight = MediaQuery.of(context).size.height * 0.28
        : cardHeight = 0);
  }

  @override
  Widget build(BuildContext context) {
    bool isRecording = _recorder.isRecording;

    return Container(
      alignment: const Alignment(0, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AttachContainer(
            containerHeight: cardHeight,
            galleryTap: _sendImgFromGallery,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (val) => onChangeInput(val),
                    controller: _msgController,
                    autofocus: true,
                    maxLines: 4,
                    minLines: 1,
                    style: TextStyle(color: context.theme.authAppBarTextColor),
                    decoration: InputDecoration(
                      hintText: 'Message',
                      isDense: true,
                      filled: true,
                      fillColor: context.theme.chatInputColor,
                      hintStyle: TextStyle(color: context.theme.greyColor),
                      prefixIcon: CustomIcon(
                        onPressed: () {},
                        icon: Icons.emoji_emotions_outlined,
                        color: Theme.of(context).listTileTheme.iconColor,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIcon(
                            onPressed: () {
                              onPressAttachIcon(context);
                            },
                            icon: cardHeight == 0
                                ? Icons.attach_file_outlined
                                : Icons.close,
                            turns: cardHeight == 0 ? 45 / 360 : 0,
                            color: Theme.of(context).listTileTheme.iconColor,
                          ),
                          CustomIcon(
                            onPressed: () {},
                            icon: Icons.camera_alt_outlined,
                            color: Theme.of(context).listTileTheme.iconColor,
                          ),
                        ],
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onLongPress: () async {
                    await _recorder.toggle();
                    setState(() {});
                  },
                  onLongPressEnd: (val) async {
                    await _recorder.toggle();
                    setState(() {});
                    debugPrint("عتشيييييييييييييييييييي");
                  },
                  // onLongPressCancel: () async {
                  //   debugPrint("اتكنسللللللللللللللللل");
                  // },
                  child: CustomIcon(
                    onPressed: () async => await _sendTextMsg(context),
                    icon: _isThereMsg ? Icons.send : Icons.mic_none_rounded,
                    color: Colors.white,
                    background: Colory.greenLight,
                    minWidth: 48,
                    iconSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
