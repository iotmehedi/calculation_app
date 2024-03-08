import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  const CustomSimpleTextField({
    super.key,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.prefixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: prefixIcon,
        ),
      prefixIconColor: prefixIconColor,
        suffixIcon: suffixIcon,
      ),
    );
  }
}