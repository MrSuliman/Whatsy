import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';

Future<void> scrollDown(widget) async {
    await Future.delayed(const Duration(milliseconds: 250));
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        widget.scrollController.animateTo(
          widget.scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      },
    );
  }