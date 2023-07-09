import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/widget/custom_btn.dart';
import 'package:whatsy/features/welcome/view/widget/welcome_img.dart';
import 'package:whatsy/features/welcome/view/widget/privacy_policy.dart';
import 'package:whatsy/core/widget/lang_btn.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: WelcomeImg(),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'Welcome to Whatsy',
                  style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const PrivacyPolicy(),
                CustomBtn(
                  onPressed: () {
                    context.pushReplacement('/login');
                  },
                  text: "AGREE AND CONTINUE",
                ),
                const SizedBox(height: 50),
                const LangBtn(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
