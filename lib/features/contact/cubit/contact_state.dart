part of 'contact_cubit.dart';

@immutable
abstract class ContactState extends Equatable {}

class ContactSuccess extends ContactState {
  final List<List<UserModel>> contacts;

  ContactSuccess({required this.contacts});

  @override
  List<Object?> get props => [contacts];
}

class ContactLoading extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactError extends ContactState {
  ContactError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
