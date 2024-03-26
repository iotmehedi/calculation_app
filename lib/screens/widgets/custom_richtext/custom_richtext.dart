import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/src/hexcolor_base.dart';

class CustomRichText extends StatelessWidget {
  final String title, heading;
  final HexColor color;
  final double? fontSize;
  const CustomRichText({super.key, required this.title, required this.color, required this.heading, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return RichText(
  text: TextSpan(
    text: heading,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: fontSize ?? 16,
      color: Colors.black
    ),
    children:  <TextSpan>[
      TextSpan(text: title, style: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: fontSize ?? 16,
      color: color
    ),),
    ],
  ),
);
  }
}