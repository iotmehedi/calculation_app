import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/consts/textstyle.dart';

class CustomRowWithRichtext extends StatelessWidget {
  final String title, richTextTitle, richTextValue;
  final FontWeight? titleFontWeight, richTextTitleFontWeight, richTextValueFontWeight;
  final FontWeight? headingFontWeight;
  final Color? titleColor, richtextTitleColor, richTextValueColor;
  final Color? headingColor;
  final double? headingFontSize, titleFontSIze;
  const CustomRowWithRichtext({
    super.key,
    required this.title,
    this.titleFontWeight,
    this.headingFontWeight,
    this.titleColor,
    this.headingColor,
    required this.richTextTitle,
    this.richtextTitleColor,
    this.richTextTitleFontWeight,
    required this.richTextValue,
    this.richTextValueColor,
    this.richTextValueFontWeight,
    this.titleFontSIze,
    this.headingFontSize
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: globalText16(
                  text: title,
                  fontWeight: titleFontWeight ?? FontWeight.w500,
                  color: titleColor,
                  textAlign: TextAlign.start)),
          Expanded(
            child: CustomRichText(
              title: richTextValue,
              titleTextColor: richTextValueColor,
              heading: richTextTitle,
              headingTextColor: richtextTitleColor,
              titleFontWeight: richTextValueFontWeight,
              headingFontWeight: richTextTitleFontWeight,
              titleFontSIze: titleFontSIze,
              headingFontSize: headingFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
