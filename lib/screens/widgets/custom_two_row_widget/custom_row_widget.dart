import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/utils/consts/textstyle.dart';

Widget CustomHalfRow(
    {required String title,
      required String value,
      required HexColor headingColor,
      required HexColor valueColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      globalText16(
          text: title, color: headingColor, fontWeight: FontWeight.w500),
      globalText16(
          text: value, color: valueColor, fontWeight: FontWeight.w500),
    ],
  );
}