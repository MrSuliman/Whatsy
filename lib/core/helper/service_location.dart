import 'package:get_it/get_it.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';
import 'package:whatsy/features/auth/cubit/save_user_cubit/save_user_cubit.dart';
import 'package:whatsy/features/contact/cubit/contact_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(),
  );

  getIt.registerLazySingleton<PickImgCubit>(
    () => PickImgCubit(),
  );

  getIt.registerLazySingleton<SaveUserCubit>(
    () => SaveUserCubit(),
  );

  getIt.registerLazySingleton<ContactCubit>(
    () => ContactCubit(),
  );
}
