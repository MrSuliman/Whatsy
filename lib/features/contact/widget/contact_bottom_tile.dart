import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/features/contact/widget/option_tile.dart';

class ContactBottomTile extends StatelessWidget {
  const ContactBottomTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            OptionTile(
              onTap: () {},
              title: 'Share invite link',
              icon: Icons.share,
              iconColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colory.greyDark
                      : Colory.greyLight,
            ),
            OptionTile(
              onTap: () {},
              title: 'Contacts help',
              icon: Icons.question_mark,
              iconColor:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colory.greyDark
                      : Colory.greyLight,
            ),
          ],
        ),
      ),
    );
  }
}
