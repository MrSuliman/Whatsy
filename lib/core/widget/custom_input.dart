import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    this.onTap,
    this.onChanged,
    this.readOnly,
    this.keyboardType,
    this.textAlign,
    this.suffixIcon,
    this.prefixText,
    this.controller,
    this.hintText,
    this.fontSize,
    this.autofocus = false,
    this.validateText,
    this.letterSpacing,
    this.maxLength,
    this.counterText,
  }) : super(key: key);

  final void Function()? onTap;
  final void Function(String?)? onChanged;
  final bool? readOnly;
  final String? hintText;
  final double? fontSize;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final Widget? suffixIcon;
  final String? prefixText;
  final TextEditingController? controller;
  final bool autofocus;
  final String? validateText;
  final double? letterSpacing;
  final int? maxLength;
  final String? counterText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType : null,
      autofocus: autofocus,
      style: TextStyle(
        letterSpacing: letterSpacing,
      ),
      maxLength: maxLength,
      decoration: InputDecoration(
        counterText: counterText,
        isDense: true,
        suffix: suffixIcon,
        prefixText: prefixText,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          letterSpacing: letterSpacing,
          color: context.theme.greyColor,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colory.greenDark),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colory.greenDark, width: 2),
        ),
      ),
    );
  }
}
