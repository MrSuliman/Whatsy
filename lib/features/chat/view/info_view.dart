import 'package:flutter/material.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/widget/avatar_img.dart';

class InfoView extends StatelessWidget {
  const InfoView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: InfoHeader(userModel),
            pinned: true,
          ),
        ],
      ),
    );
  }
}

class InfoHeader extends SliverPersistentHeaderDelegate {
  const InfoHeader(this.userModel);
  final UserModel userModel;

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.red,
      child: Stack(
        children: [
          Positioned(
            child: AvatarImg(
              backgroundImage: NetworkImage(userModel.imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
