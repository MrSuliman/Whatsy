import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Db {
// * Authentication
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final User currentUser = auth.currentUser!;

// * Cloud Storage
  static const String profileImage = 'profile_image';
  static final FirebaseStorage storage = FirebaseStorage.instance;

// * Store
  static final FirebaseFirestore store = FirebaseFirestore.instance;

  static const String users = 'users';
  static const String chats = 'chats';
  static const String messages = 'messages';

// * Database
  static const String infoConnected = 'info/connected';

  static final FirebaseDatabase realTime = FirebaseDatabase.instance;
}
