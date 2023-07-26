import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/scroll_down.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
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
  bool isThereMsg = false;
  double containerHeight = 0;
  late final TextEditingController _msgController;

  @override
  void initState() {
    _msgController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void onChangeInput(String val) {
    setState(
      () {
        if (val.trim().isEmpty) {
          isThereMsg = false;
        } else {
          isThereMsg = true;
        }
      },
    );
  }

  Future<void> onPressSend(BuildContext context) async {
    if (isThereMsg) {
      await BlocProvider.of<ChatCubit>(context).sendMsg(
        msg: _msgController.text,
        reciverId: widget.reciverId,
        senderData:
            await BlocProvider.of<AuthCubit>(context).getCurrentUserInfo(),
      );
      _msgController.clear();
      setState(
        () {
          isThereMsg = false;
        },
      );
      await scrollDown(widget);
    }
  }

  void onPressAttachIcon(BuildContext context) {
    setState(
      () => containerHeight == 0
          ? containerHeight = MediaQuery.of(context).size.height * 0.28
          : containerHeight = 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AttachContainer(containerHeight: containerHeight),
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
                            icon: containerHeight == 0
                                ? Icons.attach_file_outlined
                                : Icons.close,
                            turns: containerHeight == 0 ? 45 / 360 : 0,
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
                CustomIcon(
                  onPressed: () async => await onPressSend(context),
                  icon: isThereMsg ? Icons.send : Icons.mic_none_rounded,
                  color: Colors.white,
                  background: Colory.greenLight,
                  minWidth: 48,
                  iconSize: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
