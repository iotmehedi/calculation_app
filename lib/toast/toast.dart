import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../core/utils/consts/app_assets.dart';
import '../core/utils/consts/textstyle.dart';

void errorToast({required BuildContext context, required String msg,  Color? color, Color? iconColor, Color? headingTextColor, Color? valueTextColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 6.0,
    backgroundColor: color ??  Colors.red[400],
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    content: Row(
      children: [
         Icon(
          Icons.error,
          size: 50,
          color: iconColor ?? Colors.white,
        ),
        const SizedBox(width: 16),
        Flexible(
          // Wrap the Column in Flexible
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Error",
                style: TextStyle(
                  color: headingTextColor ?? Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                msg,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style:  TextStyle(color: valueTextColor ?? Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  ));
}



void errorToast1({required BuildContext context, required String msg,  Color? color, Color? iconColor, Color? headingTextColor, Color? valueTextColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 6.0,
    backgroundColor: color ??  Colors.red[400],
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    content: Row(
      children: [
        Image.asset(AppAssets.noInternet, height: 30, width: 40,),
        const SizedBox(width: 16),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              globalText16(text: "Whops, No Internet Connetion ", fontFamily: true, fontWeight: FontWeight.w400,color: HexColor("437AFF")),
              Text(
                msg,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style:  TextStyle(color: valueTextColor ?? Colors.white),
              ),
            ],
          ),
        ),
      ],
    ),
  ));
}