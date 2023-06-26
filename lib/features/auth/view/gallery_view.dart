import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsy/core/helper/service_location.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/msg_to_user.dart';
import 'package:whatsy/core/widget/appbar.dart';
import 'package:whatsy/core/widget/custom_icon.dart';
import 'package:whatsy/core/widget/loading.dart';
import 'package:whatsy/features/auth/cubit/pick_img_cubit/pick_img_cubit.dart';

class GalleryView extends StatefulWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  bool isMoreLoading = false;
  final ScrollController _controller = ScrollController();

  Future<void> _scrollListener() async {
    if (isMoreLoading) return;
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isMoreLoading = true;
      });
      BlocProvider.of<PickImgCubit>(context).currentPage++;
      await BlocProvider.of<PickImgCubit>(context).fetchGallery();
      setState(() {
        isMoreLoading = false;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    BlocProvider.of<PickImgCubit>(context).fetchGallery();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            return Padding(
              padding: const EdgeInsets.all(4),
              child: GridView.builder(
                controller: _controller,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: state.images.length,
                itemBuilder: (context, index) {
                  return state.images[index];
                },
              ),
            );
          } else if (state is PickImgError) {
            showMsgToUser(context: context, msg: state.error);
          }
          return const Loading();
        },
      ),
    );
  }
}
