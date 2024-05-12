import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CalorieResultScrren extends StatelessWidget {
  final int maintainWeight, mildWeightLoss, weightLoss, extremeWeightLoss;
  const CalorieResultScrren({
    super.key,
    required this.maintainWeight,
    required this.mildWeightLoss,
    required this.weightLoss,
    required this.extremeWeightLoss,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Results',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
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
              child: globalText24(text: "Calculator", color: Colors.white),
            ),
          ),
          Container(
            height: 120,
            color: HexColor("0F182E"),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAssets.brmCalculationPic,
                  height: 67.58,
                  width: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalText20(
                          text: "Maintain weight", color: HexColor("7BFF80")),
                      CustomRichText(
                        heading: '$maintainWeight',
                        title: ' Calories/day',
                        headingTextColor: HexColor('7BFF80'),
                        titleTextColor: HexColor('FFFFFF'),
                        headingFontSize: 24.0,
                        titleFontSIze: 18,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 120,
            color: HexColor("0F182E"),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText20(
                      text: "Mild weight loss (0.5 kg/week):",
                      color: HexColor("7BFF80")),
                  CustomRichText(
                    heading: '$mildWeightLoss',
                    title: '/ Calories/day',
                    headingTextColor: HexColor('7BFF80'),
                    titleTextColor: HexColor('FFFFFF'),
                    headingFontSize: 24.0,
                    titleFontSIze: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 120,
            color: HexColor("0F182E"),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText20(
                      text: "Weight loss (1 kg/week):",
                      color: HexColor("7BFF80")),
                  CustomRichText(
                    heading: '$weightLoss',
                    title: '/ Calories/day',
                    headingTextColor: HexColor('7BFF80'),
                    titleTextColor: HexColor('FFFFFF'),
                    headingFontSize: 24.0,
                    titleFontSIze: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 120,
            color: HexColor("0F182E"),
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  globalText20(
                      text: "Extreme weight loss (2 kg/week):",
                      color: HexColor("7BFF80")),
                  CustomRichText(
                    heading: '$extremeWeightLoss',
                    title: '/ Calories/day',
                    headingTextColor: HexColor('7BFF80'),
                    titleTextColor: HexColor('FFFFFF'),
                    headingFontSize: 24.0,
                    titleFontSIze: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
