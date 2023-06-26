import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/widget/bottom_sheet_header.dart';
import 'package:whatsy/core/widget/short_h_bar.dart';

showLangBottomSheet(context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ShortHBar(),
          const BottomSheetHeader(text: 'App Language'),
          Divider(
            color: context.theme.greyColor!.withOpacity(0.3),
            thickness: 0.5,
          ),
          RadioListTile(
            onChanged: (val) {},
            value: true,
            groupValue: true,
            activeColor: Colory.greenDark,
            title: const Text('English'),
            subtitle: Text(
              "(phone's language)",
              style: TextStyle(
                color: context.theme.greyColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
