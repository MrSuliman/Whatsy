import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class MainHomeFooter extends StatelessWidget {
  const MainHomeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.of(context).size.width * 0.28,
      ),
      child: Column(
        children: [
          Text(
            'Tap and hold on a chat for more options',
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Divider(
              color: context.theme.greyColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                size: 15,
                color: context.theme.greyColor,
              ),
              const SizedBox(width: 3),
              Text.rich(
                TextSpan(
                  text: 'Your personal messages are ',
                  style: Theme.of(context).textTheme.labelMedium,
                  children: [
                    TextSpan(
                      text: 'end-to-end encrypted',
                      style: TextStyle(
                          fontSize: 12, color: context.theme.greenColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
