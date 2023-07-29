import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/constant/data_base.dart';
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

    try {
      var image = (imageUrl is! String && imageUrl != null)
          ? await storeFileToStorage(
              file: imageUrl,
              path: '${Db.profileImage}/${Db.currentUser.uid}',
            )
          : '';

      UserModel user = UserModel(
        id: Db.currentUser.uid,
        name: name,
        imageUrl: image,
        phone: Db.currentUser.phoneNumber!,
        active: true,
        lastSeen: DateTime.now().millisecondsSinceEpoch,
      );

      await Db.store
          .collection(Db.users)
          .doc(Db.currentUser.uid)
          .set(user.toJson());

      emit(SaveUserSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(SaveUserError(error: e.toString()));
    }
  }
}
