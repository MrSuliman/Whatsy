import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/img_picker_type.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';

class InfoAvatar extends StatelessWidget {
  const InfoAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showImagePickerType(context),
      child: BlocBuilder<PickImgCubit, PickImgState>(
        builder: (context, state) {
          return CircleAvatar(
            radius: 80,
            backgroundColor: context.theme.photoBgColor,
            backgroundImage: (state is GalleryImgPicked)
                ? MemoryImage(state.galleryImg!)
                : (state is CameraImgPicked)
                    ? FileImage(state.cameraImg!) as ImageProvider
                    : null,
            child: (state is! GalleryImgPicked && state is! CameraImgPicked)
                ? Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: context.theme.photoIconColor,
                  )
                : null,
          );
        },
      ),
    );
  }
}
