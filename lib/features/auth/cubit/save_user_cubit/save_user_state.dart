part of 'save_user_cubit.dart';

@immutable
abstract class SaveUserState extends Equatable {}

class SaveUserInitial extends SaveUserState {
  @override
  List<Object?> get props => [];
}

class SaveUserLoading extends SaveUserState {
  @override
  List<Object?> get props => [];
}

class SaveUserSuccess extends SaveUserState {
  @override
  List<Object?> get props => [];
}

class SaveUserError extends SaveUserState {
  final String error;

  SaveUserError({required this.error});

  @override
  List<Object?> get props => [error];
}
