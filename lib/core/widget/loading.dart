import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colory.greenDark,
      ),
    );
  }
}
