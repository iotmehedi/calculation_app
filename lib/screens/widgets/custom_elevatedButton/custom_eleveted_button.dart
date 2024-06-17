import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? color;
  final HexColor? hexColor;
  final VoidCallback? onPress;
  final text;
  const CustomElevatedButton(
      {super.key, this.color, this.onPress, this.hexColor, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: hexColor ?? color,
          // minimumSize: Size(MediaQuery.of(context).size.width, 60),
          // maximumSize: Size(MediaQuery.of(context).size.width, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: onPress,
      child: Padding(padding: EdgeInsets.symmetric(vertical: 15), child: text,),
    );
  }
}
