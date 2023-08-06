import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsy/core/constant/data_base.dart';

Future<String> storeFileToStorage({var file, required String path}) async {
  UploadTask? uploadTask;
  Reference reference = Db.storage.ref().child(path);

  if (file is File) {
    uploadTask = reference.putFile(file);
  }

  if (file is Uint8List) {
    uploadTask = reference.putData(file);
  }

  TaskSnapshot snapshot = await uploadTask!;
  String url = await snapshot.ref.getDownloadURL();
  return url;
}
