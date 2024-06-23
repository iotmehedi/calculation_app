import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/utils/consts/textstyle.dart';

class CustomDropdownbutton extends StatelessWidget {
  final String value, headingName;
  final Function(String?)? onChanged;
  final Iterable<String> items;
  const CustomDropdownbutton(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.items, required this.headingName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        globalText16(text: headingName, fontWeight: FontWeight.normal),
        5.ph,
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: HexColor("#F3F6F9"),
                    borderRadius: BorderRadius.circular(12)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    value: value,
                    isExpanded: true,
                    onChanged: onChanged,
                    items: items.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox())
          ],
        ),
      ],
    );
  }
}
