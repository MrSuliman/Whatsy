import 'package:get_it/get_it.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(),
  );

  // getIt.registerLazySingleton<SaveUserCubit>(
  //   () => SaveUserCubit(),
  // );
  //
  // getIt.registerLazySingleton<ContactCubit>(
  //   () => ContactCubit(),
  // );
  //
  // getIt.registerLazySingleton<PickImgCubit>(
  //   () => PickImgCubit(),
  // );

  // getIt.registerLazySingleton<AppObserver>(
  //   () => AppObserver(),
  // );
}
