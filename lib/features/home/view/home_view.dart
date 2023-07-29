import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/helper/app_observer.dart';
import 'package:whatsy/core/helper/my_behavior.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/last_message.dart';
import 'package:whatsy/core/model/state_model.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/core/widget/skelton.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';
import 'package:whatsy/features/home/view/main_home_view.dart';
import 'package:whatsy/features/home/view/status_view.dart';
import 'package:whatsy/features/home/widget/floating_btn.dart';

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

  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            'Whatsy',
            style: Theme.of(context).textTheme.titleLarge,
          ),
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
          bottom: TabBar(
            indicatorWeight: 4,
            labelStyle: Theme.of(context).textTheme.titleMedium,
            tabs: const [
              Tab(text: "Chats"),
              Tab(text: "Updates"),
            ],
          ),
        ).appBar(context),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: StreamBuilder<List<LastMsgModel>>(
            stream: BlocProvider.of<ChatCubit>(context).fetchLastMsg(),
            builder: (_, snapshot) {
              return TabBarView(
                children: [
                  if (snapshot.connectionState == ConnectionState.active) ...[
                    MainHomeView(lastMsgModel: snapshot.data!),
                  ],
                  if (snapshot.connectionState == ConnectionState.waiting) ...[
                    const Skelton(),
                  ],
                  const StatusView(),
                ],
              );
            },
          ),
        ),
        floatingActionButton: FloatingBtn(
          onPressed: () {
            context.push(contact);
          },
          icon: initialIndex == 0 ? Icons.chat : Icons.edit,
        ),
      ),
    );
  }
}
