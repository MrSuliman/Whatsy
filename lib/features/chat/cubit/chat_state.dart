part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {}

class ChatError extends ChatState {}

class ChatLoading extends ChatState {}
