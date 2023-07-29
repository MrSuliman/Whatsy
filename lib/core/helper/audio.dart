import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsy/core/utils/ask_permission.dart';

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
    _recorder = null;
    _isRecordInit = false;
    await _recorder!.closeRecorder();
  }

  Future<void> toggle() async {
    if (_recorder!.isStopped) {
      await _record();
      debugPrint("بيريكورد يا برووووووووووووووووو");
    } else {
      await _stop();
    }
  }

  Future<void> _record() async {
    if (!_isRecordInit) return;
    var tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/audio';

    await _recorder!.startRecorder(
      toFile: path,
    );
  }

  Future<void> _stop() async {
    if (!_isRecordInit) return;
    await _recorder!.stopRecorder();
  }
}
