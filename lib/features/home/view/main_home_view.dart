import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/helper/service_location.dart';
import 'package:whatsy/core/widget/custom_btn.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/home/widget/floating_btn.dart';

class MainHomeView extends StatelessWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomBtn(
          onPressed: () async {
            await getIt.get<AuthCubit>().logOut(context);
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
    );
  }
}
