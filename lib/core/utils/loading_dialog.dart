import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

showLoadingDialog(context, {required String text}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colory.greenDark,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 15,
                  color: context.theme.greyColor,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
