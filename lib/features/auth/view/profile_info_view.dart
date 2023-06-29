import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/helper/service_location.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_btn.dart';
import 'package:whatsy/core/widget/custom_input.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';
import 'package:whatsy/features/auth/cubit/save_user_cubit/save_user_cubit.dart';
import 'package:whatsy/features/auth/widget/profile_avatar.dart';

class ProfileInfoView extends StatefulWidget {
  const ProfileInfoView({Key? key}) : super(key: key);

  @override
  State<ProfileInfoView> createState() => _ProfileInfoViewState();
}

class _ProfileInfoViewState extends State<ProfileInfoView> {
  late TextEditingController? _nameController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    getIt.get<SaveUserCubit>().close();
    _nameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Profile info',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: context.theme.authAppBarTextColor,
            ),
          ),
        ).appBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Please provide your name and an optional profile photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.5,
                    color: context.theme.greyColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 24, 40, 24),
                  child: AvatarImg(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: _autoValidate,
                        child: CustomInput(
                          validator: (val) {
                            if (val!.trim().isEmpty) {
                              return 'Please provide a username';
                            } else if (val.length < 3 || val.length > 20) {
                              return 'A username length should be between 3-20';
                            }
                            return null;
                          },
                          controller: _nameController,
                          maxLength: 20,
                          hintText: 'Type your name here',
                          autofocus: true,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.emoji_emotions_outlined,
                      color: context.theme.photoIconColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: CustomBtn(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await BlocProvider.of<SaveUserCubit>(context).saveUserInfo(
                context,
                name: _nameController!.text,
              );
            }
            _autoValidate = AutovalidateMode.always;
          },
          text: 'NEXT',
          width: 85,
        ),
      ),
    );
  }
}
