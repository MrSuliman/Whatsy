import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/share_sms_link.dart';
import 'package:whatsy/features/contact/widget/contact_tile.dart';

class InviteToWhatsy extends StatelessWidget {
  const InviteToWhatsy({super.key, required this.phoneContact});

  final List<List<UserModel>> phoneContact;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: phoneContact[1].length,
        (BuildContext context, int index) {
          return ContactTile(
            onTap: () => shareSmsLink(
              phoneContact: phoneContact,
              index: index,
            ),
            userImg: phoneContact[1][index].imageUrl,
            icon: Icons.person,
            title: phoneContact[1][index].name,
            subtitle: phoneContact[1][index].phone,
            textBtn: 'INVITE',
            onPressed: () => shareSmsLink(
              phoneContact: phoneContact,
              index: index,
            ),
          );
        },
      ),
    );
  }
}
