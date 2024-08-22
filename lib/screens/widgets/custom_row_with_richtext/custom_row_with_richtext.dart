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
  final bool? textAlignMostRight, titleFontFamily,richtextFontFamily, richTextTitleFontFamily;
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
    this.headingFontSize,
    this.textAlignMostRight,
    this.titleFontFamily,
    this.richtextFontFamily,
    this.richTextTitleFontFamily
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: textAlignMostRight == false ? 2 : 1,
              child: globalText16(
                  text: title,
                  fontWeight: titleFontWeight ?? FontWeight.w500,
                  color: titleColor,
                  textAlign: TextAlign.start, fontFamily: titleFontFamily)),
           Visibility(
             visible: textAlignMostRight == false ? false : true,
             child: Expanded(
               flex: 2,
               child: CustomRichText(
                  title: richTextValue,
                  titleTextColor: richTextValueColor,
                  heading: richTextTitle,
                  headingTextColor: richtextTitleColor,
                  titleFontWeight: richTextValueFontWeight,
                  headingFontWeight: richTextTitleFontWeight,
                  titleFontSIze: titleFontSIze,
                  headingFontSize: headingFontSize,
                 fontFamily: richtextFontFamily,
                 titleFontFamily: richTextTitleFontFamily,
                ),
             ),
           ),
          Visibility(
            visible: textAlignMostRight == false ? true : false,
            child: Expanded(
              flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: CustomRichText(
                title: richTextValue,
                titleTextColor: richTextValueColor,
                heading: richTextTitle,
                headingTextColor: richtextTitleColor,
                titleFontWeight: richTextValueFontWeight,
                headingFontWeight: richTextTitleFontWeight,
                titleFontSIze: titleFontSIze,
                headingFontSize: headingFontSize,
                fontFamily: richtextFontFamily,
                titleFontFamily: richTextTitleFontFamily,
              ),
            ),
          ),)
        ],
      ),
    );
  }
}
