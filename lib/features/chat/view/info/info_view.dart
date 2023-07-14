import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsy/core/helper/my_behavior.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/features/chat/view/info/widget/block_report.dart';
import 'package:whatsy/features/chat/view/info/widget/custom_list_tile.dart';
import 'package:whatsy/features/chat/view/info/widget/icon_with_text.dart';
import 'package:whatsy/features/chat/view/info/widget/info_appbar.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.profileBg,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: InfoAppBar(userModel),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        userModel.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        userModel.phone,
                        style: TextStyle(
                          fontSize: 18,
                          color: context.theme.greyColor,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (userModel.id !=
                              FirebaseAuth.instance.currentUser!.uid) ...[
                            const IconWithText(
                              icon: Icons.call_rounded,
                              text: 'Audio',
                            ),
                            const SizedBox(width: 34),
                            const IconWithText(
                              icon: Icons.video_call_rounded,
                              text: 'Video',
                            ),
                            const SizedBox(width: 34),
                          ],
                          const IconWithText(
                            icon: Icons.search_rounded,
                            text: 'Search',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 30),
                      title: const Text('Hey there, I\'m using whatsy'),
                      subtitle: Text(
                        '17 June, 2023',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: context.theme.greyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomListTile(
                      leading: const Icon(Icons.notifications_rounded),
                      title: 'Mute notifications',
                      trailing: Switch(
                        onChanged: (val) {},
                        value: false,
                      ),
                    ),
                    const CustomListTile(
                      leading: Icon(Icons.music_note_rounded),
                      title: 'Custom notifications',
                    ),
                    const CustomListTile(
                      leading: Icon(Icons.image_rounded),
                      title: 'Media visibility',
                    ),
                    const SizedBox(height: 10),
                    const CustomListTile(
                      leading: Icon(Icons.lock_rounded),
                      title: 'Encryption',
                      subtitle:
                          'Messages and calls are end-to-end encrypted, Tap to verify.',
                    ),
                    const CustomListTile(
                      leading: Icon(Icons.timer_rounded),
                      title: 'Disappearing messages',
                      subtitle: 'Off',
                    ),
                    const SizedBox(height: 10),
                    if (userModel.id !=
                        FirebaseAuth.instance.currentUser!.uid) ...[
                      BlockReport(
                        leading: Icons.block_rounded,
                        title: 'Block ${userModel.name}',
                      ),
                      BlockReport(
                        leading: Icons.thumb_down_rounded,
                        title: 'Report ${userModel.name}',
                      ),
                    ] else ...[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
