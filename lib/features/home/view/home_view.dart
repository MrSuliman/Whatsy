import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/features/contact/cubit/contact_cubit.dart';
import 'package:whatsy/features/home/view/call_view.dart';
import 'package:whatsy/features/home/view/main_home_view.dart';
import 'package:whatsy/features/home/view/group_view.dart';
import 'package:whatsy/features/home/view/status_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: CustomAppBar(
          title: const Text('Whatsy'),
          centerTitle: false,
          titleSpacing: 22,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: CustomIcon(
                onPressed: () async {},
                icon: Icons.camera_alt_outlined,
              ),
            ),
            CustomIcon(icon: Icons.search_outlined, onPressed: () {}),
            CustomIcon(icon: Icons.more_vert_rounded, onPressed: () {}),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            tabs: [
              Icon(
                Icons.groups_2,
                size: 28,
              ),
              Tab(text: "CHAT"),
              Tab(text: "STATUS"),
              Tab(text: "CALLS"),
            ],
          ),
        ).appBar(context),
        body: const TabBarView(
          children: [
            GroupView(),
            MainHomeView(),
            StatusView(),
            CallView(),
          ],
        ),
      ),
    );
  }
}
