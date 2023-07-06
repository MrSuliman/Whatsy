import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/core/widget/custom_input.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/auth/widget/verify_options.dart';
import 'package:whatsy/features/auth/widget/verify_rich_text.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({Key? key}) : super(key: key);

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  String smsCode = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is PhoneVerified) {
          GoRouter.of(context).pushReplacement('/profile');
        }
        if (state is AuthError) {
          showMsgToUser(context: context, msg: state.error);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: CustomAppBar(
            backgroundColor: Colors.transparent,
            // * make the navigation pushReplacement and make below this false
            title: Text(
              'Verify your number',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: context.theme.authAppBarTextColor,
              ),
            ),
            actions: [
              CustomIcon(
                onPressed: () {},
                icon: Icons.more_vert,
              ),
            ],
          ).appBar(context),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const VerifyRichText(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 10, 80, 20),
                    child: CustomInput(
                      onChanged: (val) {
                        smsCode = val!;
                        if (val.length == 6) {
                          BlocProvider.of<AuthCubit>(context).verifySmsCode(
                            context,
                            smsCode: smsCode.trim(),
                          );
                        }
                      },
                      hintText: '-----',
                      letterSpacing: 8,
                      fontSize: 26,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Text(
                    'Enter 6-digits code.',
                    style: TextStyle(
                      color: context.theme.greyColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const VerifyOptions(icon: Icons.message, text: 'Resend SMS'),
                  Divider(color: context.theme.blueColor!.withOpacity(0.2)),
                  const VerifyOptions(icon: Icons.call, text: 'Call me'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
