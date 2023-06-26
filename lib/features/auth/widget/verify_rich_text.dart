import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';

class VerifyRichText extends StatelessWidget {
  const VerifyRichText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          height: 1.5,
          color: context.theme.greyColor,
        ),
        children: [
          TextSpan(
            text:
                "You've tried to register ${BlocProvider.of<AuthCubit>(context).phoneNumber}. wait before requesting an SMS or call with your code. ",
          ),
          TextSpan(
            text: 'Wrong number?',
            style: TextStyle(
              color: context.theme.blueColor,
            ),
          ),
        ],
      ),
    );
  }
}
