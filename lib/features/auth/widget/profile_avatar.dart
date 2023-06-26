import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/img_picker_type.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';

class AvatarImg extends StatelessWidget {
  const AvatarImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PickImgCubit>(context);
    return GestureDetector(
      onTap: () => showImagePickerType(context),
      child: BlocBuilder<PickImgCubit, PickImgState>(
        builder: (context, state) {
          if (state is GalleryImgPicked) {
            return CircleAvatar(
              radius: 80,
              backgroundImage: MemoryImage(cubit.galleryImg!),
            );
          } else if (state is CameraImgPicked) {
            return CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(cubit.cameraImg!),
            );
          }
          return CircleAvatar(
            radius: 80,
            backgroundColor: context.theme.photoBgColor,
            child: Icon(
              Icons.add_a_photo_rounded,
              size: 48,
              color: context.theme.photoIconColor,
            ),
          );
        },
      ),
    );
  }
}
