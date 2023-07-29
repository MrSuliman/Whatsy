import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/last_message.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/is_that_you.dart';
import 'package:whatsy/core/widget/contact_card.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key, required this.lastMsgModel});

  final List<LastMsgModel> lastMsgModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 6),
              shrinkWrap: true,
              itemCount: lastMsgModel.length,
              itemBuilder: (_, index) => ContactCard(
                onTap: () {
                  context.push(
                    chat,
                    extra: UserModel(
                      id: lastMsgModel[index].contactId,
                      name: lastMsgModel[index].name,
                      imageUrl: lastMsgModel[index].imageUrl,
                      phone: '',
                      active: false,
                      lastSeen: 0,
                    ),
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${lastMsgModel[index].name} ${isThatYou(lastMsgModel[index].contactId, Db.currentUser.uid)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      DateFormat.Hm().format(lastMsgModel[index].timeSent),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                subtitle: lastMsgModel[index].lastMsg,
                userImg: lastMsgModel[index].imageUrl,
              ),
            ),
            // if (lastMsgModel.isNotEmpty) const MainHomeFooter(),
          ],
        ),
      ),
      
    );
  }
}
