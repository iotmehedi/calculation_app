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
  final String? hint, suffixText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? prefixIconColor, hintTextColor;
  final bool? paddingNeed, onlyNeedSuffix;
  final TextAlign? textAlign;
  final FontWeight? fontWeight, hintFontWeight;
  final double? fontSize, hintTextFontSize;
  final MaterialColor? color;
  final HexColor? hexColor;
  final String? Function(String?)? validator;
  CustomSimpleTextField(
      {super.key,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.keyboardType,
      this.textInputAction,
      this.prefixIconColor,
      this.paddingNeed,
      this.textAlign,
      this.fontWeight,
      this.fontSize,
      this.color,
      this.hexColor,
      this.validator,
      this.suffixText,
        this.hintTextFontSize,
        this.hintFontWeight,
        this.hintTextColor,
      this.onlyNeedSuffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: HexColor("#F3F6F9"), borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
          keyboardType: keyboardType ?? TextInputType.number,
          textInputAction: textInputAction,
          textAlign: textAlign ?? TextAlign.start,
          controller: controller,
          validator: validator,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color ?? hexColor),
          decoration:
              // paddingNeed == false
              //     ? InputDecoration(
              //         hintText: hint,
              //         border: InputBorder.none,
              //         hintStyle: globalTextStyle(),
              //         contentPadding: const EdgeInsets.only(right: 10, left: 10),
              //       )
              //     : onlyNeedSuffix == true
              //         ?
              InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  suffixIcon: suffixIcon,
                  suffixText: suffixText,
                  suffixStyle: TextStyle(color: Colors.black, fontSize: 20),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    top: paddingNeed == false ? 0 : 10,
                    bottom: paddingNeed == false ? 10 : 0,
                  ),
                  hintStyle: TextStyle(
                    fontSize: hintTextFontSize ?? 16,
                    fontWeight: hintFontWeight ?? FontWeight.w400,
                    color: hintTextColor ?? Colors.black,
                  ))
          // : InputDecoration(
          //     hintText: hint,
          //     border: InputBorder.none,
          //     prefixIcon: Padding(
          //       padding: EdgeInsets.only(left: 16),
          //       child: prefixIcon,
          //     ),
          //     prefixIconColor: prefixIconColor,
          //     suffixIcon: suffixIcon,
          //     suffixText: suffixText,
          //     suffixStyle: TextStyle(color: Colors.black, fontSize: 20),
          //     contentPadding: EdgeInsets.only(top: 12),
          //   ),
          ),
    );
  }
}
