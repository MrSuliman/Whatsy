import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/helper/page_animation.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';
import 'package:whatsy/features/auth/cubit/save_user_cubit/save_user_cubit.dart';
import 'package:whatsy/features/auth/view/gallery_view.dart';
import 'package:whatsy/features/auth/view/lgoin_view.dart';
import 'package:whatsy/features/auth/view/profile_info_view.dart';
import 'package:whatsy/features/auth/view/verification_view.dart';
import 'package:whatsy/features/chat/view/chat/chat_view.dart';
import 'package:whatsy/features/chat/view/info/info_view.dart';
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
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/verify',
        builder: (context, state) => const VerificationView(),
      ),
      GoRoute(
        path: '/profile', // profile
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<SaveUserCubit>(
                create: (context) => SaveUserCubit(),
              ),
              BlocProvider<PickImgCubit>(
                create: (context) => PickImgCubit(),
              ),
            ],
            child: ProfileInfoView(
              // cameraImg: state.extra as File?,
              galleryImg: state.extra as Uint8List?,
            ),
          );
        },
      ),
      GoRoute(
        path: '/gallery', // picker
        builder: (context, state) {
          return BlocProvider<PickImgCubit>(
            create: (context) => PickImgCubit(),
            child: const GalleryView(),
          );
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/contact',
        builder: (context, state) => BlocProvider<ContactCubit>(
          create: (context) => ContactCubit(),
          child: const ContactView(),
        ),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => ChatView(
          userModel: state.extra as UserModel,
        ),
      ),
      GoRoute(
        path: '/info',
        pageBuilder: (context, state) {
          return pageAnimation(
            state: state,
            page: InfoView(userModel: state.extra as UserModel),
          );
        },
      ),
    ],
  );
}


