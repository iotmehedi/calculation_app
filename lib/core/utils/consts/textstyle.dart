// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/src/hexcolor_base.dart';

globalText2(
    {required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required TextAlign textAlignment,
    Alignment? alignment}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      child: Text(
        text,
        maxLines: 2,
        textAlign: textAlignment,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          letterSpacing: 0.2,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    ),
  );
}

globalText1(
    {required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required TextAlign textAlignment,
    Alignment? alignment}) {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      child: Text(
        text,
        maxLines: 2,
        textAlign: textAlignment,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          // letterSpacing: 0.2,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    ),
  );
}

globalTextSixteen(
    {required String text,
    Alignment? alignment,
    HexColor? color,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: SizedBox(
      child: Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          letterSpacing: 0.2,
          color: color ?? Colors.black,
          fontSize: 16.0,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    ),
  );
}

globalText24(
    {required String text,
    Alignment? alignment,
    Color? color,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: SizedBox(
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          letterSpacing: 0.2,
          color: color ?? Colors.black,
          fontSize: 24.0,
          fontWeight: fontWeight ?? FontWeight.w700,
        ),
      ),
    ),
  );
}

globalText20(
    {required String text,
    Alignment? alignment,
    Color? color,
    HexColor? hexColor,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 20.0,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    ),
  );
}
globalText10(
    {required String text,
    Alignment? alignment,
    Color? color,
    HexColor? hexColor,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 10.0,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    ),
  );
}

globalText12(
    {required String text,
    Alignment? alignment,
    Color? color,
    HexColor? hexColor,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 12.0,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    ),
  );
}

globalText32(
    {required String text,
    Alignment? alignment,
    Color? color,
    HexColor? hexColor}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

globalText14(
    {required String text,
    Alignment? alignment,
    Color? color,
    HexColor? hexColor, FontWeight? fontWeight,TextAlign? textAlign,}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 14.0,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    ),
  );
}

globalText16(
    {required String text,
    Alignment? alignment,
    TextAlign? textAlign,
    Color? color,
    HexColor? hexColor,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign:  textAlign ??TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 16.0,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    ),
  );
}
globalText18(
    {required String text,
    Alignment? alignment,
    Color? color,
    HexColor? hexColor,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 18.0,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    ),
  );
}

globalText28(
    {required String text,
    Alignment? alignment,
    Color? color,
    HexColor? hexColor,
    FontWeight? fontWeight}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        letterSpacing: 0.2,
        color: color ?? hexColor,
        fontSize: 28.0,
        fontWeight: fontWeight ?? FontWeight.w700,
      ),
    ),
  );
}

globalTextStyle() {
  return GoogleFonts.poppins(
    letterSpacing: 0.2,
    color: HexColor('80848A'),
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );
}
