import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/utils/consts/textstyle.dart';

class CommonResultHeading extends StatelessWidget {
  final String headingName;
  const CommonResultHeading({super.key, required this.headingName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor('33743A'),
            HexColor('FAFFFA'),
          ],
          stops: [
            0.0,
            1.0,
          ],
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: globalText24(text: headingName, color: Colors.white),
      ),
    );
  }
}

class CustomResultMonthly extends StatelessWidget {
  final String heading, title;
  final Color? titleColor, headingColor;
  const CustomResultMonthly(
      {super.key,
      required this.heading,
      required this.title,
      this.headingColor,
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: HexColor("0F182E"),
      child: Center(
          child: CustomRichText(
        title: title,
        titleTextColor: titleColor,
        heading: heading,
        headingTextColor: headingColor,
        titleFontWeight: FontWeight.w600,
        headingFontWeight: FontWeight.w600,
        headingFontSize: 20,
        titleFontSIze: 20,
      )),
    );
  }
}
