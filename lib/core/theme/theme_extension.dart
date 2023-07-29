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
    this.chatPageBg,
    this.chatDoodleBg,
    this.senderChatCardBg,
    this.reciverChatCardBg,
    this.yellowCardBgColor,
    this.yellowCardTextColor,
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
  final Color? chatPageBg;
  final Color? chatDoodleBg;
  final Color? senderChatCardBg;
  final Color? reciverChatCardBg;
  final Color? yellowCardBgColor;
  final Color? yellowCardTextColor;

  static const lightMode = MyColors(
    greyColor: Colory.greyDark,
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
    chatPageBg: Color(0xFFEFE7DE),
    chatDoodleBg: Colors.white70,
    senderChatCardBg: Color(0xFFE7FFDB),
    reciverChatCardBg: Color(0xFFFFFFFF),
    yellowCardBgColor: Color(0xFFFFEECC),
    yellowCardTextColor: Colory.greyLight, // Color(0xFF13191C)
  );

  static const darkMode = MyColors(
    greyColor: Colory.greyLight,
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
    chatInputColor: Colory.bgGrey,
    chatPageBg: Color(0xFF081419),
    chatDoodleBg: Color(0xFF172428),
    senderChatCardBg: Color(0xFF005C4B),
    reciverChatCardBg: Colory.bgGrey,
    yellowCardBgColor: Color(0xFF222E35),
    yellowCardTextColor: Color(0xFFFFD279),
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
    Color? chatPageBg,
    Color? chatDoodleBg,
    Color? senderChatCardBg,
    Color? reciverChatCardBg,
    Color? yellowCardBgColor,
    Color? yellowCardTextColor,
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
      blockReportColor: blockReportColor ?? this.blockReportColor,
      chatInputColor: chatInputColor ?? this.chatInputColor,
      chatPageBg: chatPageBg ?? this.chatPageBg,
      chatDoodleBg: chatDoodleBg ?? this.chatDoodleBg,
      senderChatCardBg: senderChatCardBg ?? this.senderChatCardBg,
      reciverChatCardBg: reciverChatCardBg ?? this.reciverChatCardBg,
      yellowCardBgColor: yellowCardBgColor ?? this.yellowCardBgColor,
      yellowCardTextColor: yellowCardTextColor ?? this.yellowCardTextColor,
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
      chatPageBg: Color.lerp(chatPageBg, other.chatPageBg, t),
      chatDoodleBg: Color.lerp(chatDoodleBg, other.chatDoodleBg, t),
      senderChatCardBg: Color.lerp(senderChatCardBg, other.senderChatCardBg, t),
      yellowCardBgColor:
          Color.lerp(yellowCardBgColor, other.yellowCardBgColor, t),
      yellowCardTextColor:
          Color.lerp(yellowCardTextColor, other.yellowCardTextColor, t),
      reciverChatCardBg:
          Color.lerp(reciverChatCardBg, other.reciverChatCardBg, t),
    );
  }
}
