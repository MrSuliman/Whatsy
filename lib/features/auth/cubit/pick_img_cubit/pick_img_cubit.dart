import 'dart:io';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatsy/features/auth/widget/image_item.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_img_state.dart';

class PickImgCubit extends Cubit<PickImgState> {
  PickImgCubit() : super(PickedImgInitial());

  int currentPage = 0;
  File? cameraImg;
  Uint8List? galleryImg;
  List<Widget> imagesList = [];

  Future<void> pickImgFromCamera() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickedImage != null) {
        cameraImg = File(pickedImage.path);
        galleryImg = null;
        emit(CameraImgPicked());
      }
    } catch (e) {
      emit(PickImgError(error: e.toString()));
    }
  }

  FutureBuilder<Uint8List?> _image(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(
        const ThumbnailSize.square(200),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ImageItem(
            ontTap: () {
              Navigator.pop(
                context,
                galleryImg = snapshot.data,
              );
              cameraImg = null;
              emit(GalleryImgPicked());
              imagesList.clear();
            },
            image: snapshot.data!,
          );
        }
        return const SizedBox();
      },
    );
  }

  Future<void> fetchGallery() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    try {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );

      List<AssetEntity> photos = await albums[0].getAssetListPaged(
        page: currentPage,
        size: 24,
      );

      List<Widget> temp = [];
      temp.clear();

      for (var asset in photos) {
        temp.add(
          _image(asset),
        );
      }
      imagesList.addAll(temp);
      emit(GallerySuccess(images: imagesList));
    } catch (e) {
      emit(PickImgError(error: e.toString()));
    }
  }
}
