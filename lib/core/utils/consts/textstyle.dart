// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

GlobalText({required String text, required Color color, required double fontSize, required FontWeight fontWeight}) {
  return Text(
    text,
    maxLines: 1,
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      letterSpacing: 0.2,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

GlobalText1({required String text, required Color color, required double fontSize, required FontWeight fontWeight}) {
  return Text(
    text,
    maxLines: 2,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    ),
  );
}

globalText2(text, fontSize, fontWeight, color) {
  return SizedBox(
    width: 30,
    child: Text(
      text,
      maxLines: 2,
      textAlign: TextAlign.end,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        letterSpacing: 0.2,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}
