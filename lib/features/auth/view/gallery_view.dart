import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/loading.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  void initState() {
    BlocProvider.of<PickImgCubit>(context).controller.addListener(
          BlocProvider.of<PickImgCubit>(context).scrollListener,
        );
    BlocProvider.of<PickImgCubit>(context).fetchGalleryImg();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        elevation: 3,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: Text(
          'Gallery',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: context.theme.authAppBarTextColor,
          ),
        ),
      ).appBar(context),
      body: BlocBuilder<PickImgCubit, PickImgState>(
        builder: (context, state) {
          if (state is GallerySuccess) {
            return GridView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              controller: BlocProvider.of<PickImgCubit>(context).controller,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                return state.images[index];
              },
            );
          } else if (state is PickedError) {
            return Center(
              child: Text(state.error),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
