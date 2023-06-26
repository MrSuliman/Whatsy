import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Observer implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('CHANGED: $bloc');
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('CLOSED: $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    debugPrint('CREATED: $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('ERROR: $bloc with $error');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('EVENT: $bloc with $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('TRANSITION: $bloc with $transition');
  }
}
