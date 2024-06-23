import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../custom_elevatedButton/custom_eleveted_button.dart';

class CustomCalculateClearWidget extends StatelessWidget {
  final VoidCallback? onPressCalculate, onPressClear;
  const CustomCalculateClearWidget({super.key, required this.onPressCalculate, required this.onPressClear});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomElevatedButton(
              color: HexColor("244384"),
              onPress: onPressCalculate,
              // RouteGenerator.pushNamed(context, Routes.mortgageResultPage);
              text: const Text(
                "Calculate",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          10.pw,
          Expanded(
            child: CustomElevatedButton(
              color: HexColor("F3F6F9"),
              onPress: onPressClear,
              text: Text(
                "Clear",
                style: TextStyle(
                    color: HexColor("0F182E"),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
