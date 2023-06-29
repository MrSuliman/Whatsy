import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/helper/service_location.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/auth/cubit/save_user_cubit/save_user_cubit.dart';
import 'package:whatsy/features/auth/view/gallery_view.dart';
import 'package:whatsy/features/auth/view/lgoin_view.dart';
import 'package:whatsy/features/auth/view/profile_info_view.dart';
import 'package:whatsy/features/auth/view/verification_view.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';
import 'package:whatsy/features/chat/view/chat_view.dart';
import 'package:whatsy/features/contact/cubit/contact_cubit.dart';
import 'package:whatsy/features/contact/view/contact_view.dart';
import 'package:whatsy/features/home/view/home_view.dart';
import 'package:whatsy/features/welcome/view/welcome_view.dart';

abstract class Routes {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                FlutterNativeSplash.remove();
                return const HomeView();
              } else {
                FlutterNativeSplash.remove();
                return const WelcomeView();
              }
            },
          );
        },
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeView(),
      ),
      GoRoute(
        path: '/login', // login
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: '/verify',
        builder: (context, state) => const VerificationView(),
      ),
      GoRoute(
        path: '/profile', // profile
        builder: (context, state) {
          return BlocListener<SaveUserCubit, SaveUserState>(
            listener: (context, state) {
              if (state is SaveUserSuccess) {
                Navigator.pop(context);
                context.pushReplacement('/home');
              } else if (state is SaveUserError) {
                Navigator.pop(context);
              }
            },
            child: const ProfileInfoView(),
          );
        },
      ),
      GoRoute(
        path: '/picker',
        builder: (context, state) => const GalleryView(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            // if (state is SignOut) {
            //   context.pushReplacement('/welcome');
            // }
          },
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => BlocProvider<ContactCubit>(
          create: (context) => getIt.get<ContactCubit>(),
          child: const ContactView(),
        ),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => ChatView(
          userModel: state.extra as UserModel,
        ),
      ),
    ],
  );
}
