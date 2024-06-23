import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/src/hexcolor_base.dart';

class CustomRichText extends StatelessWidget {
  final String title, heading;
  final Color? titleTextColor, headingTextColor;
  final double? headingFontSize, titleFontSIze;
  final FontWeight? titleFontWeight, headingFontWeight;
  const CustomRichText(
      {super.key,
      required this.title,
      required this.titleTextColor,
      required this.heading,
      this.headingFontSize,
      this.headingTextColor,
      this.titleFontSIze,
      this.titleFontWeight,
      this.headingFontWeight,
      });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: heading,
        style: GoogleFonts.poppins(
            fontWeight: headingFontWeight ?? FontWeight.w600,
            fontSize: headingFontSize ?? 16,
            color: headingTextColor ?? Colors.black),
        children: <TextSpan>[
          const TextSpan(
            text: ' ',  // Adding a space between the two text spans
          ),
          TextSpan(
            text: title,
            style: GoogleFonts.poppins(
                fontWeight: titleFontWeight ?? FontWeight.w600,
                fontSize: titleFontSIze ?? 16,
                color: titleTextColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRichThreeText extends StatelessWidget {
  final String title, heading, value;
  final Color? titleTextColor, headingTextColor, valueTextColor;
  final double? headingFontSize, titleFontSIze, valueFontSize;
  final FontWeight? titleFontWeight, headingFontWeight, valueFontWeight;
  const CustomRichThreeText(
      {super.key,
      required this.title,
        this.titleTextColor,
      required this.heading,
      this.headingFontSize,
      this.headingTextColor,
      this.titleFontSIze,
      this.titleFontWeight,
      this.headingFontWeight,
       required this.value,
        this.valueFontSize,
        this.valueFontWeight,
        this.valueTextColor
      });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: heading,
        style: GoogleFonts.poppins(
            fontWeight: headingFontWeight ?? FontWeight.w600,
            fontSize: headingFontSize ?? 16,
            color: headingTextColor ?? Colors.black),
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: GoogleFonts.poppins(
                fontWeight: titleFontWeight ?? FontWeight.w600,
                fontSize: titleFontSIze ?? 16,
                color: titleTextColor ?? Colors.black),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.poppins(
                fontWeight: valueFontWeight ?? FontWeight.w600,
                fontSize: valueFontSize ?? 16,
                color: valueTextColor ?? Colors.black),
          ),
        ],
      ),
    );
  }
}
