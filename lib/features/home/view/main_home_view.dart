import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/last_message.dart';
import 'package:whatsy/features/home/widget/chat_card.dart';
import 'package:whatsy/features/home/widget/main_home_footer.dart';
import 'package:whatsy/features/home/widget/floating_btn.dart';

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
              itemBuilder: (_, index) => ChatCard(lastMsgModel[index]),
            ),
            if (lastMsgModel.isNotEmpty) const MainHomeFooter(),
          ],
        ),
      ),
      floatingActionButton: FloatingBtn(
        onPressed: () {
          context.push(contact);
        },
        icon: Icons.chat,
      ),
    );
  }
}
