import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/is_that_you.dart';
import 'package:whatsy/features/contact/widget/contact_card.dart';

class ContactsOnWhatsy extends StatelessWidget {
  const ContactsOnWhatsy({super.key, required this.firebaseContact});

  final List<UserModel> firebaseContact;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: firebaseContact.length,
        (BuildContext context, int index) {
          return ContactCard(
            onTap: () {
              context.pop();
              context.push(
                chat,
                extra: firebaseContact[index],
              );
            },
            userImg: firebaseContact[index].imageUrl,
            icon: firebaseContact[index].imageUrl.isEmpty
                ? Icons.person
                : null,
            title:
                '${firebaseContact[index].name} ${isThatYou(firebaseContact[index].id, Db.currentUser.uid)}',
            subtitle: 'Hey there! I\'m using whatsy',
          );
        },
      ),
    );
  }
}
