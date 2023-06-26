import 'package:flutter/material.dart';

class FloatingBtn extends StatelessWidget {
  const FloatingBtn({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
