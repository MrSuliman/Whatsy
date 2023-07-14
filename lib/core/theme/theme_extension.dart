import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';

extension ExtendedTheme on BuildContext {
  MyColors get theme {
    return Theme.of(this).extension<MyColors>()!;
  }
}

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    this.greyColor,
    this.blueColor,
    this.langBtnColor,
    this.highlightColor,
    this.circleImgColor,
    this.authAppBarTextColor,
    this.photoBgColor,
    this.photoIconColor,
    this.greenColor,
    this.profileBg,
    this.blockReportColor,
    this.chatInputColor,
  });

  final Color? greyColor;
  final Color? blueColor;
  final Color? langBtnColor;
  final Color? highlightColor;
  final Color? circleImgColor;
  final Color? authAppBarTextColor;
  final Color? photoBgColor;
  final Color? photoIconColor;
  final Color? greenColor;
  final Color? profileBg;
  final Color? blockReportColor;
  final Color? chatInputColor;

  static const lightMode = MyColors(
    greyColor: Colory.greyLight,
    blueColor: Colory.blueLight,
    langBtnColor: Color(0xFFF7F8FA),
    highlightColor: Color(0xFFE8E8ED),
    circleImgColor: Color(0xFF25D366),
    authAppBarTextColor: Colory.greenDark,
    photoIconColor: Color(0xFF9dAAB3),
    photoBgColor: Color(0xFFF0F2F3),
    greenColor: Colory.greenLight,
    profileBg: Color(0xFFF7F8FA),
    blockReportColor: Colors.red,
    chatInputColor: Colors.white,
  );

  static const darkMode = MyColors(
    greyColor: Colory.greyDark,
    blueColor: Colory.blueDark,
    langBtnColor: Color(0xFF182229),
    highlightColor: Color(0xFF09141A),
    circleImgColor: Colory.greenDark,
    authAppBarTextColor: Color(0xFFE9EDEF),
    photoIconColor: Color(0xFF61717B),
    photoBgColor: Color(0xFF283339),
    greenColor: Colory.greenDark,
    profileBg: Color(0xFF0B141A),
    blockReportColor: Color(0xFFF15c6D),
  );

  @override
  ThemeExtension<MyColors> copyWith({
    Color? greyColor,
    Color? blueColor,
    Color? langBtnColor,
    Color? highlightColor,
    Color? circleImgColor,
    Color? authAppBarTextColor,
    Color? photoIconColor,
    Color? photoBgColor,
    Color? profileBg,
    Color? blockReportColor,
    Color? chatInputColor,
  }) {
    return MyColors(
      greyColor: greyColor ?? this.greyColor,
      blueColor: blueColor ?? this.blueColor,
      langBtnColor: langBtnColor ?? this.langBtnColor,
      highlightColor: highlightColor ?? this.highlightColor,
      circleImgColor: circleImgColor ?? this.circleImgColor,
      authAppBarTextColor: authAppBarTextColor ?? this.authAppBarTextColor,
      photoIconColor: photoIconColor ?? this.photoIconColor,
      photoBgColor: photoBgColor ?? this.photoBgColor,
      profileBg: profileBg ?? this.profileBg,
      blockReportColor: profileBg ?? this.blockReportColor,
      chatInputColor: chatInputColor ?? this.chatInputColor,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      greyColor: Color.lerp(greyColor, other.greyColor, t),
      blueColor: Color.lerp(blueColor, other.blueColor, t),
      langBtnColor: Color.lerp(langBtnColor, other.langBtnColor, t),
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t),
      circleImgColor: Color.lerp(circleImgColor, other.circleImgColor, t),
      authAppBarTextColor: Color.lerp(
        authAppBarTextColor,
        other.authAppBarTextColor,
        t,
      ),
      photoIconColor: Color.lerp(photoIconColor, other.photoIconColor, t),
      photoBgColor: Color.lerp(photoBgColor, other.photoBgColor, t),
      profileBg: Color.lerp(profileBg, other.profileBg, t),
      blockReportColor: Color.lerp(blockReportColor, other.blockReportColor, t),
      chatInputColor: Color.lerp(chatInputColor, other.chatInputColor, t),
    );
  }
}
