import 'package:flutter/material.dart';
import 'package:whatsy/core/widget/custom_icon.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomIcon(
            onPressed: () => Navigator.pop(context),
            icon: Icons.close_outlined,
          ),
        ],
      ),
    );
  }
}
