import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:flutter/material.dart';

class HomepageWidget extends StatelessWidget {
  final String images, text;
  final VoidCallback? onPress;
  const HomepageWidget(
      {super.key, required this.images, required this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          Image.asset(
            images,
            height: 30,
            width: 30,
          ),
          const SizedBox(
            height: 5,
          ),
          globalText2(
            text: text,
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            textAlignment: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
