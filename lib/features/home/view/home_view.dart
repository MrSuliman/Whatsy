import 'package:flutter/material.dart';
import 'package:whatsy/core/helper/app_observer.dart';
import 'package:whatsy/core/model/state_model.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/features/home/view/call_view.dart';
import 'package:whatsy/features/home/view/main_home_view.dart';
import 'package:whatsy/features/home/view/group_view.dart';
import 'package:whatsy/features/home/view/status_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  final appObserver = AppObserver();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(appObserver);
    appObserver.onlineUser(
      StateModel(
        active: true,
        lastSeen: DateTime.now().millisecondsSinceEpoch,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    appObserver.offlineUser();
    WidgetsBinding.instance.removeObserver(appObserver);
    super.dispose();
  }

  @override
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
