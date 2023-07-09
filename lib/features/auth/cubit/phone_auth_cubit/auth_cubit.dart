import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/helper/app_observer.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/utils/loading_dialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? phoneNumber;
  String? verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;

  Stream<UserModel> getUserPresence(String id) {
    return _store
        .collection('users')
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
      await _auth.verifyPhoneNumber(
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
          Navigator.pop(context);
          if (e.code == 'invalid-phone-number') {
            emit(AuthError(error: 'Invalid phone number.'));
            emit(AuthInitial());
          }
        },
      );
    } catch (_) {
      Navigator.pop(context);
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
      Navigator.pop(context);
      emit(AuthError(error: 'Invalid sms code, check again.'));
      emit(AuthInitial());
    } catch (_) {
      Navigator.pop(context);
      emit(AuthError(error: 'Something went wrong, resend sms code.'));
    }
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    await _auth.signInWithCredential(credential);
    emit(PhoneVerified());
  }

  Future<void> logOut(BuildContext context) async {
    AppObserver().offlineUser();
    await _auth.signOut();
    context.pushReplacement('/welcome');
  }
}
