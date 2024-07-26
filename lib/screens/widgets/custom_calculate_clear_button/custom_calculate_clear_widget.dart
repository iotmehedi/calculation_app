import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../custom_elevatedButton/custom_eleveted_button.dart';

class CustomCalculateClearWidget extends StatelessWidget {
  final VoidCallback? onPressCalculate, onPressClear;
  final double? clearButtonTitleFontSize;
  final FontWeight? clearButtonFontWeight;
  final Color? clearButtonTextColor;
  const CustomCalculateClearWidget(
      {super.key,
      required this.onPressCalculate,
      required this.onPressClear,
      this.clearButtonTitleFontSize,
      this.clearButtonFontWeight,
      this.clearButtonTextColor});

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
              text: const Text(
                "Calculate",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
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
                    fontSize: clearButtonTitleFontSize ?? 14,
                    color: clearButtonTextColor ?? HexColor("0F182E"),
                    fontWeight: clearButtonFontWeight ?? FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCalculateClearWidget1 extends StatelessWidget {
  final VoidCallback? onPressCalculate, onPressClear;
  final double? clearButtonTitleFontSize;
  final FontWeight? clearButtonFontWeight;
  final Color? clearButtonTextColor;
  const CustomCalculateClearWidget1(
      {super.key,
      required this.onPressCalculate,
      required this.onPressClear,
      this.clearButtonTitleFontSize,
      this.clearButtonFontWeight,
      this.clearButtonTextColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              color: HexColor("F3F6F9"),
              onPress: onPressClear,
              text: Text(
                "Clear",
                style: TextStyle(
                    fontSize: clearButtonTitleFontSize ?? 14,
                    color: clearButtonTextColor ?? HexColor("0F182E"),
                    fontWeight: clearButtonFontWeight ?? FontWeight.w500),
              ),
            ),
          ),
          10.pw,
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
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          // 10.pw,
        ],
      ),
    );
  }
}
