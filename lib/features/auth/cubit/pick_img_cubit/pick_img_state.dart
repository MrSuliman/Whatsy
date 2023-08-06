part of 'pick_img_cubit.dart';

@immutable
abstract class PickImgState extends Equatable {}

class PickedInitial extends PickImgState {
  @override
  List<Object?> get props => [];
}

class CameraImgPicked extends PickImgState {
  CameraImgPicked(this.cameraImg);

  final File? cameraImg;

  @override
  List<Object?> get props => [cameraImg];
}

class GalleryPicked extends PickImgState {
  GalleryPicked(this.galleryImg);

  final Uint8List? galleryImg;

  @override
  List<Object?> get props => [galleryImg];
}

class GallerySuccess extends PickImgState {
  GallerySuccess({required this.images});

  final List<Widget> images;

  @override
  List<Object?> get props => [images];
}

class PickedError extends PickImgState {
  PickedError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
