import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> storeFileToStorage({var file, required String path}) async {
  UploadTask? uploadTask;
  Reference storage = FirebaseStorage.instance.ref().child(path);

  if (file is File) {
    uploadTask = storage.putFile(file);
  }

  if (file is Uint8List) {
    uploadTask = storage.putData(file);
  }

  TaskSnapshot snapshot = await uploadTask!;
  String imageUrl = await snapshot.ref.getDownloadURL();
  return imageUrl;
}
