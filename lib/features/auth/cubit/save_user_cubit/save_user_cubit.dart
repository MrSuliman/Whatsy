import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/loading_dialog.dart';
import 'package:whatsy/core/utils/store_file.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';

part 'save_user_state.dart';

class SaveUserCubit extends Cubit<SaveUserState> {
  SaveUserCubit() : super(SaveUserInitial());

  Future<void> saveUserInfo(
    BuildContext context, {
    required String name,
  }) async {
    showLoadingDialog(
      context,
      text: 'Saving user info ...',
    );
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userCollection = FirebaseFirestore.instance.collection('users');

    try {
      final imageUrl = await storeFileToStorage(
        file: BlocProvider.of<PickImgCubit>(context).galleryImg ??
            BlocProvider.of<PickImgCubit>(context).cameraImg ??
            '',
        path: 'profile_image/${auth.currentUser!.uid}',
      );

      UserModel user = UserModel(
        id: auth.currentUser!.uid,
        name: name,
        imageUrl: imageUrl,
        phone: auth.currentUser!.phoneNumber!,
        active: true,
        lastSeen: DateTime.now().microsecondsSinceEpoch,
      );

      await userCollection.doc(auth.currentUser!.uid).set(user.toJson());

      emit(SaveUserSuccess());
    } catch (e) {
      emit(SaveUserError(error: e.toString()));
    }
  }
}
