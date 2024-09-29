import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CalorieResultScrren extends StatelessWidget {
  final int maintainWeight, mildWeightLoss, weightLoss, extremeWeightLoss;
  final bool unitOrMatrics;
  const CalorieResultScrren({
    super.key,
    required this.maintainWeight,
    required this.mildWeightLoss,
    required this.weightLoss,
    required this.extremeWeightLoss,
    required this.unitOrMatrics,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Results',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
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
                          heading: '${maintainWeight + 200}',
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
              height: 130,
              color: HexColor("0F182E"),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalText16(
                          text: "Estimated daily calories needed to lose weight:",
                          color: HexColor("F3F3F3"),
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start),
                      5.ph,
                      CustomRichText(
                        heading: '$mildWeightLoss',
                        title: '/ Calories/day',
                        headingTextColor: HexColor('7BFF80'),
                        titleTextColor: HexColor('FFFFFF'),
                        headingFontSize: 18.0,
                        titleFontSIze: 16,
                      ),
                      5.ph,
                      CustomRichThreeText(
                        title: unitOrMatrics == true ?"lb /" : "Kg /",
                        heading: unitOrMatrics == true ? "0.5 " : "0.25 ",
                        value: "Week",
                        headingTextColor: HexColor('7BFF80'),
                        headingFontWeight: FontWeight.bold,
                        titleFontWeight: FontWeight.w500,
                        titleFontSIze: 14,
                        titleTextColor: HexColor('F3F3F3'),
                        valueFontSize: 12,
                        valueFontWeight: FontWeight.normal,
                        valueTextColor: AppColors.deepGray1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 130,
              color: HexColor("0F182E"),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    globalText16(
                        text: "Estimated daily calories needed to lose weight:",
                        color: HexColor("F3F3F3"),
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start),
                    5.ph,
                    CustomRichText(
                      heading: '${weightLoss + 300}',
                      title: '/ Calories/day',
                      headingTextColor: HexColor('7BFF80'),
                      titleTextColor: HexColor('FFFFFF'),
                      headingFontSize: 18.0,
                      titleFontSIze: 16,
                    ),
                    5.ph,
                    CustomRichThreeText(
                      title: unitOrMatrics == true ?"lb /" : "Kg /",
                      heading: unitOrMatrics == true ? "1 " : "0.5 ",
                      value: "Week",
                      headingTextColor: HexColor('7BFF80'),
                      headingFontWeight: FontWeight.bold,
                      titleFontWeight: FontWeight.w500,
                      titleFontSIze: 14,
                      titleTextColor: HexColor('F3F3F3'),
                      valueFontSize: 12,
                      valueFontWeight: FontWeight.normal,
                      valueTextColor: AppColors.deepGray1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 130,
              color: HexColor("0F182E"),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    globalText16(
                        text: "Estimated daily calories needed to lose weight:",
                        color: HexColor("F3F3F3"),
                        fontWeight: FontWeight.normal,
                        textAlign: TextAlign.start),
                    5.ph,
                    CustomRichText(
                      heading: '${extremeWeightLoss + 350}',
                      title: '/ Calories/day',
                      headingTextColor: HexColor('7BFF80'),
                      titleTextColor: HexColor('FFFFFF'),
                      headingFontSize: 18.0,
                      titleFontSIze: 16,
                    ),
                    5.ph,
                    CustomRichThreeText(
                      title: unitOrMatrics == true ?"lb /" : "Kg /",
                      heading: unitOrMatrics == true ? "2 " : "1 ",
                      value: "Week",
                      headingTextColor: HexColor('7BFF80'),
                      headingFontWeight: FontWeight.bold,
                      titleFontWeight: FontWeight.w500,
                      titleFontSIze: 14,
                      titleTextColor: HexColor('F3F3F3'),
                      valueFontSize: 12,
                      valueFontWeight: FontWeight.normal,
                      valueTextColor: AppColors.deepGray1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
