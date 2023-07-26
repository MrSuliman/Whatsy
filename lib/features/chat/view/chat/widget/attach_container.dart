import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/features/chat/view/chat/widget/attach_icon_with_text.dart';

class AttachContainer extends StatelessWidget {
  const AttachContainer({
    super.key,
    required this.containerHeight,
  });

  final double containerHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.maxFinite,
      height: containerHeight,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: context.theme.reciverChatCardBg,
      ),
      child: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AttachIconWithText(
                    color: Color(0xFF7F66FE),
                    icon: Icons.book,
                    text: 'File',
                  ),
                  AttachIconWithText(
                    color: Color(0xFFFE2E74),
                    icon: Icons.camera,
                    text: 'camera',
                  ),
                  AttachIconWithText(
                    color: Color(0xFFC861F9),
                    icon: Icons.photo,
                    text: 'Gallery',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AttachIconWithText(
                    color: Color(0xFFF96533),
                    icon: Icons.headphones,
                    text: 'Audio',
                  ),
                  AttachIconWithText(
                    color: Color(0xFF1FA855),
                    icon: Icons.location_on,
                    text: 'Location',
                  ),
                  AttachIconWithText(
                    color: Color(0xFF009DE1),
                    icon: Icons.person,
                    text: 'Contact',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
