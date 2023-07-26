import 'dart:math';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class ShimmerMsgs extends StatelessWidget {
  const ShimmerMsgs({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        final int random = Random().nextInt(15);
        return Container(
          alignment:
              random.isEven ? Alignment.centerRight : Alignment.centerLeft,
          margin: EdgeInsets.only(
            top: 4,
            bottom: 4,
            left: random.isEven ? 5 : 15,
            right: random.isEven ? 15 : 5,
          ),
          child: ClipPath(
            clipper: UpperNipMessageClipperTwo(
              random.isEven ? MessageType.send : MessageType.receive,
              nipWidth: 10,
              nipHeight: 10,
              bubbleRadius: 12,
            ),
            child: Shimmer.fromColors(
              baseColor: random.isEven
                  ? context.theme.greyColor!.withOpacity(0.3)
                  : context.theme.greyColor!.withOpacity(0.2),
              highlightColor: random.isEven
                  ? context.theme.greyColor!.withOpacity(0.4)
                  : context.theme.greyColor!.withOpacity(0.3),
              child: Container(
                width: 140 + double.parse((random * 2).toString()),
                height: 40,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}
