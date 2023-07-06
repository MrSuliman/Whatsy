import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/widget/bottom_sheet_header.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/core/widget/short_h_bar.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';

showImagePickerType(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ShortHBar(),
          const BottomSheetHeader(text: 'Profile photo'),
          const SizedBox(height: 5),
          Divider(
            color: context.theme.greyColor!.withOpacity(0.3),
            thickness: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 15),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIcon(
                      onPressed: () async {
                        Navigator.pop(context);
                        BlocProvider.of<PickImgCubit>(context)
                            .pickImgFromCamera(context);
                      },
                      icon: Icons.camera_alt_rounded,
                      color: Colory.greenDark,
                      minWidth: 50,
                      border: Border.all(
                        width: 1,
                        color: context.theme.greyColor!.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Camera',
                      style: TextStyle(color: context.theme.greyColor),
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIcon(
                      onPressed: () {
                        Navigator.pop(context);
                        context.push('/gallery');
                      },
                      icon: Icons.photo_camera_back_rounded,
                      color: Colory.greenDark,
                      minWidth: 50,
                      border: Border.all(
                        width: 1,
                        color: context.theme.greyColor!.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Gallery',
                      style: TextStyle(color: context.theme.greyColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
