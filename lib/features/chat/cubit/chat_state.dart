part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class StateUpdated extends ChatState {}

class StateError extends ChatState {
  StateError(this.error);

  final String error;
}

class ChatLoading extends ChatState {}
