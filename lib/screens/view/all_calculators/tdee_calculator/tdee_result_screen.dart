import 'package:calculation_app/core/utils/consts/app_assets.dart';
import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/tdee_calculator/tdee_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/services/ad_services.dart';

class TdeeResultScrren extends StatelessWidget {
  TdeeResultScrren({
    super.key,
  });
  var controller = Get.find<TdeeController>();
  var adController = Get.put(AdService());
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
      bottomNavigationBar: adController.getBannerAdWidget(),
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
              color: HexColor("0F182E"),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.brmCalculationPic,
                      height: 67.58,
                      width: 60,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: globalText16(
                                  text:
                                      "TDEE or body weight maintenance energy requirement is",
                                  color: HexColor("FFFFFF"),
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500),
                            ),
                            CustomRichText(
                              heading: controller.tdeeResult.value,
                              title: 'Calories/day',
                              headingTextColor: HexColor('7BFF80'),
                              titleTextColor: HexColor('FFFFFF'),
                              headingFontSize: 24.0,
                              titleFontSIze: 18,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: controller.activityLevel.value ==
                        ActivityLevel.basalMetabolicRate
                    ? false
                    : true,
                child: const SizedBox(height: 20)),
            Visibility(
              visible: controller.activityLevel.value ==
                      ActivityLevel.basalMetabolicRate
                  ? false
                  : true,
              child: CustomRichThreeText(
                  title: " Lose weight",
                  titleFontSIze: 16,
                  titleFontWeight: FontWeight.w500,
                  titleTextColor: HexColor("2FAE3B"),
                  heading: "Energy intake to",
                  headingFontSize: 16,
                  headingFontWeight: FontWeight.w500,
                  headingTextColor: Colors.black,
                  value: " :"),
            ),
            Visibility(
                visible: controller.activityLevel.value ==
                        ActivityLevel.basalMetabolicRate
                    ? false
                    : true,
                child: const SizedBox(height: 20)),
            Visibility(
              visible: controller.activityLevel.value ==
                      ActivityLevel.basalMetabolicRate
                  ? false
                  : true,
              child: Container(
                // height: 130,
                color: HexColor("0F182E"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        globalText16(
                            text: "Mild weight lose:",
                            color: HexColor("F3F3F3"),
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.start),
                        5.ph,
                        CustomRichText(
                          heading: controller.mildWeightLoss.value,
                          title: '/ Calories/day',
                          headingTextColor: HexColor('7BFF80'),
                          titleTextColor: HexColor('FFFFFF'),
                          headingFontSize: 18.0,
                          titleFontSIze: 16,
                        ),
                        5.ph,
                        CustomRichThreeText(
                          title: controller.isMetric.value == true
                              ? "Pound /"
                              : "Kg /",
                          heading: controller.isMetric.value == true
                              ? "0.5 "
                              : "0.25 ",
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
            ),
            Visibility(
                visible: controller.activityLevel.value ==
                            ActivityLevel.basalMetabolicRate ||
                        controller.activityLevel.value ==
                            ActivityLevel.sedentary
                    ? false
                    : true,
                child: const SizedBox(height: 10)),
            Visibility(
              visible: controller.activityLevel.value ==
                          ActivityLevel.basalMetabolicRate ||
                      controller.activityLevel.value == ActivityLevel.sedentary
                  ? false
                  : true,
              child: Container(
                color: HexColor("0F182E"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalText16(
                          text: "Weight loss:",
                          color: HexColor("F3F3F3"),
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start),
                      5.ph,
                      CustomRichText(
                        heading: controller.weightLoss.value,
                        title: '/ Calories/day',
                        headingTextColor: HexColor('7BFF80'),
                        titleTextColor: HexColor('FFFFFF'),
                        headingFontSize: 18.0,
                        titleFontSIze: 16,
                      ),
                      5.ph,
                      CustomRichThreeText(
                        title: controller.isMetric.value == true
                            ? "Pound /"
                            : "Kg /",
                        heading:
                            controller.isMetric.value == true ? "1 " : "0.5 ",
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
            Visibility(
                visible: controller.activityLevel.value ==
                            ActivityLevel.basalMetabolicRate ||
                        controller.activityLevel.value ==
                            ActivityLevel.sedentary
                    ? false
                    : true,
                child: const SizedBox(height: 10)),
            Visibility(
              visible: controller.activityLevel.value ==
                          ActivityLevel.basalMetabolicRate ||
                      controller.activityLevel.value ==
                          ActivityLevel.sedentary ||
                      controller.activityLevel.value ==
                          ActivityLevel.lightlyActive ||
                      controller.activityLevel.value ==
                          ActivityLevel.moderatelyActive
                  ? false
                  : true,
              child: Container(
                color: HexColor("0F182E"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalText16(
                          text: "Extreme weight loss :",
                          color: HexColor("F3F3F3"),
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start),
                      5.ph,
                      CustomRichText(
                        heading: controller.extremeWeightLoss.value,
                        title: '/ Calories/day',
                        headingTextColor: HexColor('7BFF80'),
                        titleTextColor: HexColor('FFFFFF'),
                        headingFontSize: 18.0,
                        titleFontSIze: 16,
                      ),
                      5.ph,
                      CustomRichThreeText(
                        title: controller.isMetric.value == true
                            ? "Pound /"
                            : "Kg /",
                        heading:
                            controller.isMetric.value == true ? "2 " : "1 ",
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
            const SizedBox(height: 20),
            Visibility(
              visible: controller.activityLevel.value ==
                      ActivityLevel.basalMetabolicRate
                  ? false
                  : true,
              child: CustomRichThreeText(
                  title: " Gain weight",
                  titleFontSIze: 16,
                  titleFontWeight: FontWeight.w500,
                  titleTextColor: HexColor("2FAE3B"),
                  heading: "Energy intake to",
                  headingFontSize: 16,
                  headingFontWeight: FontWeight.w500,
                  headingTextColor: Colors.black,
                  value: " :"),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: controller.activityLevel.value ==
                      ActivityLevel.basalMetabolicRate
                  ? false
                  : true,
              child: Container(
                // height: 130,
                color: HexColor("0F182E"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        globalText16(
                            text: "Mild weight Gain:",
                            color: HexColor("F3F3F3"),
                            fontWeight: FontWeight.normal,
                            textAlign: TextAlign.start),
                        5.ph,
                        CustomRichText(
                          heading: controller.mildWeightGain.value,
                          title: '/ Calories/day',
                          headingTextColor: HexColor('7BFF80'),
                          titleTextColor: HexColor('FFFFFF'),
                          headingFontSize: 18.0,
                          titleFontSIze: 16,
                        ),
                        5.ph,
                        CustomRichThreeText(
                          title: controller.isMetric.value == true
                              ? "Pound /"
                              : "Kg /",
                          heading: controller.isMetric.value == true
                              ? "0.5 "
                              : "0.25 ",
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
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: controller.activityLevel.value ==
                      ActivityLevel.basalMetabolicRate
                  ? false
                  : true,
              child: Container(
                color: HexColor("0F182E"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalText16(
                          text: "Weight Gain:",
                          color: HexColor("F3F3F3"),
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start),
                      5.ph,
                      CustomRichText(
                        heading: controller.weightGain.value,
                        title: '/ Calories/day',
                        headingTextColor: HexColor('7BFF80'),
                        titleTextColor: HexColor('FFFFFF'),
                        headingFontSize: 18.0,
                        titleFontSIze: 16,
                      ),
                      5.ph,
                      CustomRichThreeText(
                        title: controller.isMetric.value == true
                            ? "Pound /"
                            : "Kg /",
                        heading:
                            controller.isMetric.value == true ? "1 " : "0.5 ",
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
            Visibility(
              visible: controller.activityLevel.value ==
                      ActivityLevel.basalMetabolicRate
                  ? false
                  : true,
              child: Container(
                color: HexColor("0F182E"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      globalText16(
                          text: "Extreme weight Gain :",
                          color: HexColor("F3F3F3"),
                          fontWeight: FontWeight.normal,
                          textAlign: TextAlign.start),
                      5.ph,
                      CustomRichText(
                        heading: controller.extremeWeightGain.value,
                        title: '/ Calories/day',
                        headingTextColor: HexColor('7BFF80'),
                        titleTextColor: HexColor('FFFFFF'),
                        headingFontSize: 18.0,
                        titleFontSIze: 16,
                      ),
                      5.ph,
                      CustomRichThreeText(
                        title: controller.isMetric.value == true
                            ? "Pound /"
                            : "Kg /",
                        heading:
                            controller.isMetric.value == true ? "2 " : "1 ",
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
