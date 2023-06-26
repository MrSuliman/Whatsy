import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class AuthRichText extends StatelessWidget {
  const AuthRichText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Whatsy will need to verify  your number. ",
          style: TextStyle(
            height: 1.5,
            color: context.theme.greyColor,
          ),
          children: [
            TextSpan(
              text: "What's my number?",
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
