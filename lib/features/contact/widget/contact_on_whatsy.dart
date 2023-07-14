import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/is_that_you.dart';
import 'package:whatsy/features/contact/widget/contact_tile.dart';

class ContactsOnWhatsy extends StatelessWidget {
  const ContactsOnWhatsy({super.key, required this.firebaseContact});

  final List<List<UserModel>> firebaseContact;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: firebaseContact[0].length,
        (BuildContext context, int index) {
          return ContactTile(
            onTap: () {
              context.pop();
              context.push(
                '/chat',
                extra: firebaseContact[0][index],
              );
            },
            userImg: firebaseContact[0][index].imageUrl,
            icon: firebaseContact[0][index].imageUrl.isEmpty
                ? Icons.person
                : null,
            title:
                '${firebaseContact[0][index].name} ${isThatYou(firebaseContact[0][index].id, FirebaseAuth.instance.currentUser!.uid)}',
            subtitle: 'Hey there! I\'m using whatsy',
          );
        },
      ),
    );
  }
}
