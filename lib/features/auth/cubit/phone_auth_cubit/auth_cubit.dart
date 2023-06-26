import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/utils/loading_dialog.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  String? phoneNumber;
  String? verificationId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;

  // Future<UserModel?> getCurrentUser() async {
  //   UserModel? user;
  //   final userInfo = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(auth.currentUser?.uid)
  //       .get();
  //   try {
  //     if (userInfo.data() == null) return user;
  //
  //     user = UserModel.fromJson(userInfo.data()!);
  //     // emit(CurrentUser());
  //     return user;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     emit(AuthError(error: e.toString()));
  //   }
  // }

  Future<void> sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      showLoadingDialog(
        context,
        text: 'Sending a verification code to $phoneNumber',
      );
      await auth.verifyPhoneNumber(
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
            showMsgToUser(
              context: context,
              msg: 'Invalid phone number.',
            );
            emit(AuthError(error: 'Invalid phone number.'));
          } else {
            emit(AuthError(error: e.toString()));
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
    } catch (_) {
      Navigator.pop(context);
      emit(AuthError(error: 'Something went wrong, resend sms code.'));
    }
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    await auth.signInWithCredential(credential);
    emit(PhoneVerified());
  }

  Future<void> logOut(BuildContext context) async {
    await auth.signOut();
    GoRouter.of(context).pushReplacement('/welcome');
  }

  User loggedInUserInfo() {
    return auth.currentUser!;
  }
}
