import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/widget/custom_btn.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';
import 'package:whatsy/features/home/widget/floating_btn.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatCubit>(
      create: (context) => ChatCubit(),
      child: Scaffold(
        body: Center(
          child: CustomBtn(
            onPressed: () async {
              // await getIt.get<AuthCubit>().logOut(context);
            },
            text: 'Logout',
          ),
        ),
        floatingActionButton: FloatingBtn(
          onPressed: () {
            context.push('/contact');
          },
          icon: Icons.chat,
        ),
      ),
    );
  }
}
