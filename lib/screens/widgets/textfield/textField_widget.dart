import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/src/hexcolor_base.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final Function(String?)? onChanged;

  const CustomTextField(
      {super.key,
      required this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.textInputType,
      this.textInputAction,
      required this.obscureText,
      this.validator,
      this.errorText,
      this.onChanged,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: hint,
        errorText: errorText,
        border: const OutlineInputBorder(),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: prefixIcon,
        ),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
    );
  }
}

class CustomSimpleTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final bool? paddingNeed;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final MaterialColor? color;
  final HexColor? hexColor;
  const CustomSimpleTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.prefixIconColor,
    this.paddingNeed,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.hexColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor("#F3F6F9"), borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        keyboardType: textInputType,
        textInputAction: textInputAction,
        textAlign: textAlign ?? TextAlign.start,
        controller: controller,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? hexColor),
        
        decoration: paddingNeed == false
            ? InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: globalTextStyle(),
                contentPadding: const EdgeInsets.only(right: 10, left: 10))
            : InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: prefixIcon,
                ),
                prefixIconColor: prefixIconColor,
                suffixIcon: suffixIcon,
              ),
      ),
    );
  }
}
