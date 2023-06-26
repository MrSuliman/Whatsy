import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whatsy/core/helper/observer.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';
import 'package:whatsy/features/auth/cubit/save_user_cubit/save_user_cubit.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';
import 'package:whatsy/features/contact/cubit/contact_cubit.dart';
import 'core/helper/service_location.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  setup();
  Bloc.observer = Observer();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => getIt.get<AuthCubit>(),
        ),
        BlocProvider<PickImgCubit>(
          create: (context) => getIt.get<PickImgCubit>(),
        ),
        BlocProvider<SaveUserCubit>(
          create: (context) => getIt.get<SaveUserCubit>(),
        ),
        BlocProvider<ChatCubit>(
          create: (context) => getIt.get<ChatCubit>(),
        ),
      ],
      child: const Whatsy(),
    ),
  );
}

class Whatsy extends StatelessWidget {
  const Whatsy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.router,
      debugShowCheckedModeBanner: false,
      title: 'whatsy',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
    );
  }
}
