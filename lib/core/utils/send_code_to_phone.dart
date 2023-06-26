import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';

sendCodeToPhone({
  required BuildContext context,
  required TextEditingController codeController,
  required TextEditingController nameController,
  required TextEditingController phoneController,
}) {
  final String countryCode = codeController.text;
  final String countryName = nameController.text;
  final String phoneNumber = phoneController.text.trim();

  if (phoneNumber.isEmpty) {
    return showMsgToUser(
      context: context,
      msg: 'Please enter your phone number.',
    );
  } else if (phoneNumber.length < 9) {
    return showMsgToUser(
      context: context,
      msg:
          'The phone number you entered is too short for the country $countryName.',
    );
  } else if (phoneNumber.length > 10) {
    return showMsgToUser(
      context: context,
      msg:
          'The phone number you entered is too long for the country $countryName.',
    );
  } else {
    BlocProvider.of<AuthCubit>(context).sendSmsCode(
      context: context,
      phoneNumber: '+$countryCode$phoneNumber',
    );
  }
}
