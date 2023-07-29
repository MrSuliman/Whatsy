import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/share_sms_link.dart';
import 'package:whatsy/core/widget/contact_card.dart';

class InviteToWhatsy extends StatelessWidget {
  const InviteToWhatsy({super.key, required this.phoneContact});

  final List<UserModel> phoneContact;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: phoneContact.length,
        (BuildContext context, int index) {
          return ContactCard(
            onTap: () => shareSmsLink(
              phoneContact: phoneContact,
              index: index,
            ),
            userImg: phoneContact[index].imageUrl,
            title: Text(
              phoneContact[index].name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: phoneContact[index].phone,
            trailing: TextButton(
              onPressed: () => shareSmsLink(
                phoneContact: phoneContact,
                index: index,
              ),
              child: const Text('invite'),
            ),
          );
        },
      ),
    );
  }
}
