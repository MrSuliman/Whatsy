import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class Skelton extends StatelessWidget {
  const Skelton({super.key});

  @override
  Widget build(BuildContext context) {
     return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 0,
      ),
      itemBuilder: (context, index) {
        final int random = Random().nextInt(15);
        return Shimmer.fromColors(
          baseColor: context.theme.greyColor!.withOpacity(0.3),
          highlightColor: context.theme.greyColor!.withOpacity(0.4),
          child: ListTile(
            dense: true,
            leading: const CircleAvatar(radius: 28),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80 + double.parse((random * 2).toString()),
                  height: 9,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                ),
                Container(
                  width: 20 + double.parse((random * 2).toString()),
                  height: 6,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ],
            ),
            subtitle: Container(
              width: 70 + double.parse((random * 2).toString()),
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        );
      },
    );
  }
}
