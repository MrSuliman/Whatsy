import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsy/core/constant/message_type.dart';
import 'package:whatsy/core/utils/ask_permission.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/chat/cubit/chat_cubit.dart';

class Audio {
  bool _isRecordInit = false;
  static FlutterSoundRecorder? _recorder;

  bool get isRecording => _recorder!.isRecording;

  Future<void> permisson(context) async {
    if (await Permission.microphone.status.isGranted) return;
    askPermission(
      context,
      allowBtn: () async {
        final status = await Permission.microphone.request();
        if (!status.isGranted) {
        } else if (await Permission.microphone.status.isDenied) {
          await openAppSettings();
        }
        Navigator.pop(context);
      },
      icon: Icons.mic,
      text: await Permission.microphone.status.isDenied
          ? 'To record a Voice Message, allow Whatsy access to your microphone. Tap Settings > Permissions, and turn Microphone on.'
          : 'To record a Voice Message, allow Whatsy access to your microphone.',
    );
  }

  Future<void> init() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
    _isRecordInit = true;
  }

  Future<void> dispose() async {
    if (!_isRecordInit) return;
    await _recorder!.closeRecorder();
    _recorder = null;
    _isRecordInit = false;
  }

  Future<void> toggle(context, receiverId) async {
    if (_recorder!.isStopped) {
      await _record();
      debugPrint("بيريكورد يا برووووووووووووووووو");
    } else {
      await _stop(context, receiverId);
    }
  }

  Future<String> _recordPath() async {
    Directory tempDir = await getTemporaryDirectory();
    return '${tempDir.path}/audio';
  }

  Future<void> _record() async {
    if (!_isRecordInit) return;
    return await _recorder!.startRecorder(toFile: await _recordPath());
  }

  Future<void> _stop(context, String receiverId) async {
    if (!_isRecordInit) return;
    await _recorder!.stopRecorder().then((value) async {
      if (value != null) {
        await BlocProvider.of<ChatCubit>(context).sendFile(
          msgType: MessageType.audio,
          receiverId: receiverId,
          senderData:
              await BlocProvider.of<AuthCubit>(context).getCurrentUserInfo(),
          file: File(await _recordPath()),
        );
      }
    });
  }
}
