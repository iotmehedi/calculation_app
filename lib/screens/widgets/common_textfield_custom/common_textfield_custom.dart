import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/utils/consts/textstyle.dart';
import '../textfield/textField_widget.dart';

class CommonTextFieldCustom extends StatelessWidget {
  final String headingName;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool needPadding;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? suffixText, hint;
  final TextAlign? textAlign;
  final bool? onlyNeedSuffix;
  CommonTextFieldCustom(
      {super.key,
      required this.headingName,
      required this.controller,
      required this.validator,
      required this.keyboardType,
      required this.needPadding,
      this.prefixIcon,this.suffixIcon,
        this.suffixText, this.textAlign, this.hint, this.onlyNeedSuffix});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        globalText16(text: headingName, fontWeight: FontWeight.normal, textAlign: TextAlign.start),
        5.ph,
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                      color: HexColor("#F3F6F9"),
                      borderRadius: BorderRadius.circular(12)),
                  child: CustomSimpleTextField(
                    paddingNeed: needPadding,
                    controller: controller,
                    validator: validator,
                    keyboardType: keyboardType,
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    suffixText: suffixText,
                    textAlign: textAlign,
                    onlyNeedSuffix: onlyNeedSuffix,
                    hint: hint,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ],
    );
  }
}
