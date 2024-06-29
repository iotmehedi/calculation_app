import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  const CustomText({super.key, required this.text, this.textColor, this.fontWeight, this.fontSize, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(text, style:GoogleFonts.poppins(color: textColor, fontWeight: fontWeight, fontSize: fontSize), textAlign: textAlign,);
  }
}