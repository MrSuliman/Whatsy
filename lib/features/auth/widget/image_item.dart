import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({
    Key? key,
    required this.image,
    required this.ontTap,
  }) : super(key: key);
  final Uint8List image;
  final void Function() ontTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: ontTap,
        borderRadius: BorderRadius.circular(5),
        splashFactory: NoSplash.splashFactory,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: context.theme.greyColor!.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: MemoryImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
