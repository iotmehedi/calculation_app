// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

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
        style: TextStyle(
          letterSpacing: 0.2,
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    ),
  );
}

globalTextSixteen({required String text, Alignment? alignment}) {
  return Align(
    alignment: alignment ?? Alignment.centerLeft,
    child: SizedBox(
      child: Text(
        text,
        maxLines: 2,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          letterSpacing: 0.2,
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
