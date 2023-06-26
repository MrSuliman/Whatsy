import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    Key? key,
    this.width,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final double? width;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? MediaQuery.of(context).size.width * 0.72,
          42,
        ),
      ),
      child: Text(text),
    );
  }
}
