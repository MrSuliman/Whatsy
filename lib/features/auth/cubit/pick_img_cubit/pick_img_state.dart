part of 'pick_img_cubit.dart';

@immutable
abstract class PickImgState extends Equatable {}

class PickedImgInitial extends PickImgState {
  @override
  List<Object?> get props => [];
}

class CameraImgPicked extends PickImgState {
  @override
  List<Object?> get props => [];
}

class GalleryImgPicked extends PickImgState {
  @override
  List<Object?> get props => [];
}

class GallerySuccess extends PickImgState {
  GallerySuccess({required this.images});

  final List<Widget> images;

  @override
  List<Object?> get props => [images];
}

class PickImgError extends PickImgState {
  PickImgError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
