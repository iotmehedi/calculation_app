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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.withOpacity(0.2))
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                images,
                height: 30,
                width: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          globalText1(
            text: text,
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            textAlignment: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
