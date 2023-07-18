part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class MsgSaved extends ChatState {}

class MsgSent extends ChatState {}

class StateUpdated extends ChatState {}

class ChatError extends ChatState {
  ChatError(this.error);

  final String error;
}

class ChatLoading extends ChatState {}
