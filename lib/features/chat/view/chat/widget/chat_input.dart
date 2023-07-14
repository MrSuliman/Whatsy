import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/widget/custom_icon.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool isThereMsg = false;
  late final TextEditingController msgController;

  @override
  void initState() {
    msgController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (val) {
                setState(
                  () {
                    if (val.trim().isEmpty) {
                      isThereMsg = false;
                    } else {
                      isThereMsg = true;
                    }
                  },
                );
              },
              controller: msgController,
              decoration: InputDecoration(
                hintText: 'Message',
                isDense: true,
                filled: true,
                fillColor: context.theme.chatInputColor,
                hintStyle: TextStyle(color: context.theme.greyColor),
                prefixIcon: CustomIcon(
                  onPressed: () {},
                  icon: Icons.emoji_emotions_outlined,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotatedBox(
                      quarterTurns: 45,
                      child: CustomIcon(
                        onPressed: () {},
                        icon: Icons.attach_file_outlined,
                      ),
                    ),
                    CustomIcon(
                      onPressed: () {},
                      icon: Icons.camera_alt_outlined,
                    ),
                  ],
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          CustomIcon(
            onPressed: () {},
            icon: isThereMsg == true
                ? Icons.send_outlined
                : Icons.mic_none_rounded,
            color: Colors.white,
            background: Colory.greyLight,
          )
        ],
      ),
    );
  }
}
