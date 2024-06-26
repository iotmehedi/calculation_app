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
