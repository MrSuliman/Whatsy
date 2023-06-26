import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Read our ",
          style: TextStyle(
            height: 1.5,
            color: context.theme.greyColor,
          ),
          children: [
            TextSpan(
              text: "Privacy Policy. ",
              style: TextStyle(
                color: context.theme.blueColor,
              ),
            ),
            const TextSpan(
              text: 'Tap "Agree and Continue" to accept the ',
            ),
            TextSpan(
              text: "Terms of Services. ",
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
