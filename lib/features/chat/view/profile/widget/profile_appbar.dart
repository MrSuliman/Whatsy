import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsy/core/model/user_model.dart';
import 'package:whatsy/core/widget/avatar_img.dart';
import 'package:whatsy/core/widget/custom_icon.dart';

class ProfileAppBar extends SliverPersistentHeaderDelegate {
  const ProfileAppBar(this.userModel);

  final UserModel userModel;
  final double maxHeight = 180;
  final double minHeight = 88;
  final double maxImgSize = 130;
  final double minImgSize = 44;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scroll = min(shrinkOffset, 45) / 45;
    final double percent = shrinkOffset / (maxHeight - 35);
    final double percent2 = shrinkOffset / (maxHeight);
    final double middle =
        (MediaQuery.of(context).size.width / 2) - (maxImgSize / 2);

    final double imgSize = (maxImgSize * (1 - percent)).clamp(
      minImgSize,
      maxImgSize,
    );

    final double imgPosition = (middle * (1 - percent)).clamp(
      minImgSize,
      maxImgSize,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        color: Theme.of(context)
            .appBarTheme
            .backgroundColor!
            .withOpacity(percent2 * 2 < 1 ? percent2 : 1),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 16,
              left: imgPosition + 52,
              child: Text(
                userModel.name,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(percent2),
                ),
              ),
            ),
            Positioned(
              left: 4,
              top: MediaQuery.of(context).viewPadding.top + 4,
              child: BackButton(
                onPressed: () => context.pop(),
                color: _iconColor.transform(scroll),
              ),
            ),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).viewPadding.top + 8,
              child: CustomIcon(
                onPressed: () {},
                icon: Icons.more_vert,
                color: _iconColor.transform(scroll),
              ),
            ),
            Positioned(
              left: imgPosition,
              top: MediaQuery.of(context).viewPadding.top,
              bottom: 2,
              child: SizedBox(
                width: imgSize,
                child: Hero(
                  tag: 'profile_img',
                  child: AvatarImg(
                    size: imgPosition - 12,
                    imageUrl: userModel.imageUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final _iconColor = ColorTween(
    begin: Colors.grey,
    end: Colors.white,
  );

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(ProfileAppBar oldDelegate) => false;
}
