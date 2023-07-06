import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';
import 'package:whatsy/core/utils/lang_bottom_sheet.dart';

class LangBtn extends StatelessWidget {
  const LangBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.langBtnColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => showLangBottomSheet(context),
        borderRadius: BorderRadius.circular(20),
        splashFactory: NoSplash.splashFactory,
        highlightColor: context.theme.highlightColor,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language, color: Colory.greenDark),
              SizedBox(width: 10),
              Text(
                "English",
                style: TextStyle(
                  color: Colory.greenDark,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.keyboard_arrow_down, color: Colory.greenDark),
            ],
          ),
        ),
      ),
    );
  }
}
