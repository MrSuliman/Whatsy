import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/helper/my_behavior.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/core/widget/loading.dart';
import 'package:whatsy/features/contact/cubit/contact_cubit.dart';
import 'package:whatsy/features/contact/widget/contact_counting.dart';
import 'package:whatsy/features/contact/widget/contact_on_whatsy.dart';
import 'package:whatsy/features/contact/widget/contact_top_tile.dart';
import 'package:whatsy/features/contact/widget/invite_to_whatsy.dart';
import 'package:whatsy/features/contact/widget/contact_bottom_tile.dart';
import 'package:whatsy/features/contact/widget/contact_title.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  @override
  void initState() {
    BlocProvider.of<ContactCubit>(context).fetchContacts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      left: MediaQuery.of(context).orientation == Orientation.landscape
          ? true
          : false,
      bottom: false,
      right: false,
      child: Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: true,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Contact',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 3),
              const ContactCounting(),
            ],
          ),
          actions: [
            CustomIcon(onPressed: () {}, icon: Icons.search),
            CustomIcon(onPressed: () {}, icon: Icons.more_vert_rounded),
          ],
        ).appBar(context),
        body: ScrollConfiguration(
          behavior: MyBehavior(),
          child: BlocBuilder<ContactCubit, ContactState>(
            builder: (context, state) {
              if (state is ContactSuccess) {
                return CustomScrollView(
                  slivers: [
                    const ContactTopTile(),
                    const ContactTitle(title: 'Contacts on whatsy'),
                    ContactsOnWhatsy(firebaseContact: state.contacts[0]),
                    const ContactTitle(title: 'Invite to whatsy'),
                    InviteToWhatsy(phoneContact: state.contacts[1]),
                    const ContactBottomTile(),
                  ],
                );
              } else if (state is ContactError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Loading();
              }
            },
          ),
        ),
      ),
    );
  }
}
