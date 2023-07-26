import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/helper/routes.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/loading_dialog.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_btn.dart';
import 'package:whatsy/core/widget/custom_input.dart';
import 'package:whatsy/features/auth/cubit/save_user_cubit/save_user_cubit.dart';
import 'package:whatsy/features/auth/widget/profile_avatar.dart';

class ProfileInfoView extends StatefulWidget {
  const ProfileInfoView({
    Key? key,
    this.galleryImg,
    this.cameraImg,
  }) : super(key: key);
  final File? cameraImg;
  final Uint8List? galleryImg;

  @override
  State<ProfileInfoView> createState() => _ProfileInfoViewState();
}

class _ProfileInfoViewState extends State<ProfileInfoView> {
  late TextEditingController? _nameController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveUserCubit, SaveUserState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is SaveUserLoading) {
          showLoadingDialog(context, text: 'Saving user info ...');
        } else if (state is SaveUserSuccess) {
          context.pop();
          context.pushReplacement(home);
        } else if (state is SaveUserError) {
          context.pop();
          showMsgToUser(context: context, msg: state.error);
        }
      },
      child: GestureDetector(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 24, 40, 24),
                    child: AvatarImg(
                      cameraImg: widget.cameraImg,
                      galleryImg: widget.galleryImg,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _autoValidate,
                          child: CustomInput(
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
            onPressed: () async => await _saveUser(context),
            text: 'NEXT',
            width: 85,
          ),
        ),
      ),
    );
  }

  Future<void> _saveUser(BuildContext context) async {
    if (_nameController!.text.trim().isEmpty) {
      showMsgToUser(
        context: context,
        msg: 'Please provide a username.',
      );
    } else if (_nameController!.text.length < 3 ||
        _nameController!.text.length > 20) {
      showMsgToUser(
        context: context,
        msg: 'A username length should be between 3-20 characters.',
      );
    } else {
      await BlocProvider.of<SaveUserCubit>(context).saveUserInfo(
        context,
        name: _nameController!.text,
        imageUrl: widget.cameraImg ?? widget.galleryImg ?? '',
      );
    }
    _autoValidate = AutovalidateMode.always;
  }
}
