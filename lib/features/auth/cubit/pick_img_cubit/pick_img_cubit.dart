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
  PickImgCubit() : super(PickedImgInitial());

  int limit = 20;
  int currentPage = 0;
  List<Widget> imagesList = [];
  File? cameraImg;
  Uint8List? galleryImg;
  final ScrollController controller = ScrollController();

  Future<void> scrollListener() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      currentPage++;
      await fetchGallery();
    }
  }

  Future<void> pickImgFromCamera(context) async {
    try {
      await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
        if (value != null) {
          galleryImg = null;
          cameraImg = File(value.path);
          emit(CameraImgPicked(cameraImg));
        }
      });
    } catch (e) {
      emit(PickImgError(error: e.toString()));
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
              emit(GalleryImgPicked(galleryImg));
              Navigator.pop(context, galleryImg);
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
        size: limit,
      );

      for (var asset in photos) {
        imagesList.add(_pickImgFromGallery(asset));
      }

      emit(PickedImgInitial());
      emit(GallerySuccess(images: imagesList));
    } catch (e) {
      emit(PickImgError(error: e.toString()));
    }
  }
}
