import 'dart:io';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatsy/features/auth/widget/image_item.dart';
import 'package:image_picker/image_picker.dart';

part 'pick_img_state.dart';

class PickImgCubit extends Cubit<PickImgState> {
  PickImgCubit() : super(PickedInitial());

  int limit = 20;
  int currentPage = 0;
  List<Widget> assetsList = [];
  File? cameraImg;
  Uint8List? galleryImg;
  final ScrollController controller = ScrollController();

  Future<void> scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      currentPage++;
      await fetchGalleryImg();
    }
  }

  Future<void> pickImgFromCamera(context) async {
    try {
      await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 25)
          .then((value) {
        if (value != null) {
          galleryImg = null;
          cameraImg = File(value.path);
          emit(CameraImgPicked(cameraImg));
        }
      });
    } catch (e) {
      emit(PickedError(error: e.toString()));
    }
  }

  FutureBuilder<Uint8List?> _pickImgFromGallery(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(
        const ThumbnailSize.square(200),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ImageItem(
            ontTap: () {
              cameraImg = null;
              galleryImg = snapshot.data;
              emit(GalleryPicked(galleryImg));
              Navigator.pop(context, galleryImg);
            },
            image: snapshot.data!,
          );
        }
        return const SizedBox();
      },
    );
  }

  Future<void> fetchGalleryImg() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    try {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );

      List<AssetEntity> photos = await albums[0].getAssetListPaged(
        page: currentPage,
        size: limit,
      );

      for (var asset in photos) {
        assetsList.add(_pickImgFromGallery(asset));
      }

      emit(PickedInitial());
      emit(GallerySuccess(images: assetsList));
    } catch (e) {
      emit(PickedError(error: e.toString()));
    }
  }

FutureBuilder<Uint8List?> _pickVideoFromGallery(AssetEntity asset) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(
        const ThumbnailSize.square(25),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ImageItem(
            ontTap: () {
              cameraImg = null;
              galleryImg = snapshot.data;
              emit(GalleryPicked(galleryImg));
              Navigator.pop(context, galleryImg);
            },
            image: snapshot.data!,
          );
        }
        return const SizedBox();
      },
    );
  }
  Future<void> fetchGalleryVideo() async {
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    try {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.video,
      );

      List<AssetEntity> videos = await albums[0].getAssetListPaged(
        page: currentPage,
        size: limit,
      );

      for (var asset in videos) {
        assetsList.add(_pickVideoFromGallery(asset));
      }

      emit(PickedInitial());
      emit(GallerySuccess(images: assetsList));
    } catch (e) {
      emit(PickedError(error: e.toString()));
    }
  }
}
