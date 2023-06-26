import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

Future<void> showMsgToUser({
  required BuildContext context,
  required String msg,
  String? btnText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(msg),
        contentTextStyle: TextStyle(
          height: 1.5,
          color: context.theme.greyColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              btnText ?? 'OK',
              style: TextStyle(
                color: context.theme.circleImgColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}
