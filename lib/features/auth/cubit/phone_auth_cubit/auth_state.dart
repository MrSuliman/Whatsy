part of 'auth_cubit.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

// class CurrentUser extends AuthState {
//   @override
//   List<Object?> get props => [];
// }

class AuthError extends AuthState {
  AuthError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}

class SmsCodeSent extends AuthState {
  @override
  List<Object?> get props => [];
}

class PhoneVerified extends AuthState {
  @override
  List<Object?> get props => [];
}

class SignOut extends AuthState {
  @override
  List<Object?> get props => [];
}
