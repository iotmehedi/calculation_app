import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../main.dart';
import '../../../toast/toast.dart';

class CustomElevatedButton extends StatelessWidget {
  final Color? color;
  final HexColor? hexColor;
  final VoidCallback? onPress;
  final text;
  const CustomElevatedButton(
      {super.key, this.color, this.onPress, this.hexColor, this.text});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: connectivityService.isConnected,
        builder: (context, isConnected, child) {

        return ElevatedButton(

          style: ElevatedButton.styleFrom(
            elevation: 0,
              backgroundColor: hexColor ?? color,
              minimumSize: Size(MediaQuery.of(context).size.width, 60),
              maximumSize: Size(MediaQuery.of(context).size.width, 60),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          onPressed: isConnected
              ? onPress
              : () {
            errorToast(
                context: context,
                msg: "Please check your internet connection",
                color: Colors.grey,
                iconColor: Colors.red,
                headingTextColor: Colors.red,
                valueTextColor: Colors.red);
          },
          child: text,
        );
      }
    );
  }
}
