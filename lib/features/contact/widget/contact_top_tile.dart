import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/features/contact/widget/option_tile.dart';

class ContactTopTile extends StatelessWidget {
  const ContactTopTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            OptionTile(
              onTap: () {},
              iconBg:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colory.greenLight
                      : Colory.greenDark,
              title: 'New group',
              icon: Icons.group,
              iconColor: Colors.white,
            ),
            OptionTile(
              onTap: () {},
              iconBg:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colory.greenLight
                      : Colory.greenDark,
              title: 'New contact',
              icon: Icons.person_add,
              iconColor: Colors.white,
              iconBtn: Icons.qr_code,
            ),
            OptionTile(
              onTap: () {},
              iconBg:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Colory.greenLight
                      : Colory.greenDark,
              title: 'New community',
              icon: Icons.groups,
              iconColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
