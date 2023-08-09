import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/constant/data_base.dart';
import 'package:whatsy/core/helper/app_observer.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/loading_dialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? phoneNumber;
  String? verificationId;

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo =
        await Db.store.collection(Db.users).doc(Db.auth.currentUser?.uid).get();
    if (userInfo.data() == null) return user;
    user = UserModel.fromJson(userInfo.data()!);
    return user;
  }

  Stream<UserModel> getUserPresence(String id) {
    return Db.store
        .collection(Db.users)
        .doc(id)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }

  Future<void> sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      showLoadingDialog(
        context,
        text: 'Sending a verification code to $phoneNumber',
      );
      await Db.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: (String verificationId, int? resendToken) {
          this.phoneNumber = phoneNumber;
          this.verificationId = verificationId;
          emit(SmsCodeSent());
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          await signIn(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthError(error: 'Invalid phone number.'));
          emit(AuthInitial());
        },
      );
    } catch (_) {
      emit(AuthError(error: 'Something went wrong!, please try again.'));
    }
  }

  Future<void> verifySmsCode(
    BuildContext context, {
    required String smsCode,
  }) async {
    try {
      showLoadingDialog(
        context,
        text: 'Verifying code ...',
      );
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        smsCode: smsCode,
        verificationId: verificationId!,
      );
      await signIn(credential);
    } on FirebaseAuthException catch (_) {
      emit(AuthError(error: 'Invalid sms code, check again.'));
      emit(AuthInitial());
    } catch (_) {
      emit(AuthError(error: 'Something went wrong, resend sms code.'));
    }
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    await Db.auth.signInWithCredential(credential);
    emit(PhoneVerified());
  }

  Future<void> logOut(BuildContext context) async {
    AppObserver().offlineUser();
    await Db.auth.signOut();
    if (context.mounted) {
      context.pushReplacement(welcome);
    }
  }
}
