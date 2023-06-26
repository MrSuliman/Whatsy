import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whatsy/core/constant/colors.dart';
import 'package:whatsy/core/theme/theme_extension.dart';

void showCountryCodePicker({
  required BuildContext context,
  TextEditingController? countryNameController,
  TextEditingController? countryCodeController,
}) {
  showCountryPicker(
    context: context,
    showPhoneCode: true,
    countryListTheme: CountryListThemeData(
      flagSize: 22,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      textStyle: TextStyle(color: context.theme.greyColor),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomSheetHeight: MediaQuery.of(context).size.height * 0.75,
      inputDecoration: InputDecoration(
        prefixIcon: const Icon(Icons.language),
        prefixIconColor: Colory.greenDark,
        hintText: 'Search country code or name',
        labelStyle: TextStyle(color: context.theme.greyColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: context.theme.greyColor!.withOpacity(0.2),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colory.greenDark,
          ),
        ),
      ),
    ),
    onSelect: (country) {
      countryNameController!.text = country.name;
      countryCodeController!.text = country.phoneCode;
    },
  );
}
