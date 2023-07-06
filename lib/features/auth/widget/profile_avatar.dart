import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/img_picker_type.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';

class AvatarImg extends StatelessWidget {
  const AvatarImg({
    Key? key,
    this.galleryImg,
    this.cameraImg,
  }) : super(key: key);

  final File? cameraImg;
  final Uint8List? galleryImg;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showImagePickerType(context),
      child: BlocBuilder<PickImgCubit, PickImgState>(
        builder: (context, state) {
          if (galleryImg != null && cameraImg == null) {
            return CircleAvatar(
              radius: 80,
              backgroundImage: MemoryImage(galleryImg!),
            );
          } else if (cameraImg != null && galleryImg == null) {
            return CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(
                BlocProvider.of<PickImgCubit>(context).cameraImg!,
              ),
            );
          } else {
            return CircleAvatar(
              radius: 80,
              backgroundColor: context.theme.photoBgColor,
              child: Icon(
                Icons.add_a_photo_rounded,
                size: 48,
                color: context.theme.photoIconColor,
              ),
            );
          }

        },
      ),
    );
  }
}

// if (galleryImg != null && cameraImg == null) {
//             return CircleAvatar(
//               radius: 80,
//               backgroundImage: MemoryImage(galleryImg!),
//             );
//           } else if (cameraImg != null && galleryImg == null) {
//             return CircleAvatar(
//               radius: 80,
//               backgroundImage: FileImage(
//                 BlocProvider.of<PickImgCubit>(context).cameraImg!,
//               ),
//             );
//           } else {
//             return CircleAvatar(
//               radius: 80,
//               backgroundColor: context.theme.photoBgColor,
//               child: Icon(
//                 Icons.add_a_photo_rounded,
//                 size: 48,
//                 color: context.theme.photoIconColor,
//               ),
//             );
//           }
