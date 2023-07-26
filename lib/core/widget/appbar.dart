import 'package:flutter/material.dart';

class CustomAppBar {
  const CustomAppBar({
    this.leading,
    this.title,
    this.actions,
    this.automaticallyImplyLeading,
    this.centerTitle,
    this.elevation,
    this.bottom,
    this.titleSpacing,
    this.backgroundColor,
  });

  final double? elevation;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;
  final dynamic bottom;
  final double? titleSpacing;
  final Color? backgroundColor;

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      bottom: bottom,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      elevation: elevation ?? 0,
      titleSpacing: titleSpacing,
      leadingWidth: 42,
      centerTitle: centerTitle ?? true,
      leading: leading,
      title: title,
      actions: actions,
    );
  }
}
