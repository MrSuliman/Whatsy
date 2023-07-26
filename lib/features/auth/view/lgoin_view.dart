import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/utils/send_code_to_phone.dart';
import 'package:whatsy/core/utils/country_code_picker.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_btn.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/core/widget/custom_input.dart';
import 'package:whatsy/features/auth/cubit/phone_auth_cubit/auth_cubit.dart';
import 'package:whatsy/features/auth/widget/auth_rich_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController? _countryNameController;
  TextEditingController? _countryCodeController;
  TextEditingController? _phoneNumberController;

  @override
  void initState() {
    _countryCodeController = TextEditingController(text: '966');
    _phoneNumberController = TextEditingController();
    _countryNameController = TextEditingController(text: 'Saudi Arabia');
    super.initState();
  }

  @override
  void dispose() {
    _countryCodeController!.dispose();
    _countryNameController!.dispose();
    _phoneNumberController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is PhoneVerified) {
         context.pushReplacement(profile);
        }
        if (state is SmsCodeSent) {
          context.pushReplacement(verify);
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
            title: Text(
              'Enter your phone number',
              style: TextStyle(
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
          body: Column(
            children: [
              const AuthRichText(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: CustomInput(
                  onTap: () => showCountryCodePicker(
                    context: context,
                    countryNameController: _countryNameController,
                    countryCodeController: _countryCodeController,
                  ),
                  controller: _countryNameController,
                  readOnly: true,
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colory.greenDark,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: CustomInput(
                        onTap: () => showCountryCodePicker(
                          context: context,
                          countryNameController: _countryNameController,
                          countryCodeController: _countryCodeController,
                        ),
                        controller: _countryCodeController,
                        prefixText: '+',
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomInput(
                        onTap: () {},
                        controller: _phoneNumberController,
                        hintText: 'phone number',
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Carrier changes may apply',
                style: TextStyle(
                  color: context.theme.greyColor,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: CustomBtn(
            onPressed: () {
              sendCodeToPhone(
                context: context,
                nameController: _countryNameController!,
                phoneController: _phoneNumberController!,
                codeController: _countryCodeController!,
              );
            },
            text: 'NEXT',
            width: 85,
          ),
        ),
      ),
    );
  }
}
