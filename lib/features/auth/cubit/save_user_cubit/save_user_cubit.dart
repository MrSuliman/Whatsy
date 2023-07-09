import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/store_file.dart';

part 'save_user_state.dart';

class SaveUserCubit extends Cubit<SaveUserState> {
  SaveUserCubit() : super(SaveUserInitial());

  Future<void> saveUserInfo(
    BuildContext context, {
    required String name,
    required var imageUrl,
  }) async {
    emit(SaveUserLoading());

    final FirebaseAuth auth = FirebaseAuth.instance;
    final userCollection = FirebaseFirestore.instance.collection('users');

    try {
      //  ! Need some refactor here,
      var image = imageUrl is String ? '' : imageUrl;

      if (imageUrl != null && imageUrl is! String) {
        image = await storeFileToStorage(
          file: imageUrl,
          path: 'profile_image/${auth.currentUser!.uid}',
        );
      }

      UserModel user = UserModel(
        id: auth.currentUser!.uid,
        name: name,
        imageUrl: image,
        phone: auth.currentUser!.phoneNumber!,
        active: true,
        lastSeen: DateTime.now().microsecondsSinceEpoch,
      );

      await userCollection.doc(auth.currentUser!.uid).set(user.toJson());

      emit(SaveUserSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(SaveUserError(error: e.toString()));
    }
  }
}
