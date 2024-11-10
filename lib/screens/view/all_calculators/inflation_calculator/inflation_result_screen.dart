import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/inflation_calculator/inflation_calculator.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_richtext/custom_richtext.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import 'inflation_controller.dart';

class InflationResultScreen extends StatelessWidget {
  InflationResultScreen({super.key});
  var controller = Get.find<InflationCalculatorController>();
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          appBar: CustomAppBar(
            title: "Inflation Converter",
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          // bottomNavigationBar: adController.getBannerAdWidget(),
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
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
              20.ph,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ContainerShadowWidget(
                  widget: Center(
                    child: CustomRichText(
                      title: controller.monthYearInfo.value,
                      titleTextColor: HexColor("1E1E1E"),
                      titleFontSIze: 20,
                      titleFontWeight: FontWeight.w500,
                      titleFontFamily: true,
                      heading: controller.mainResult.value,
                      headingTextColor: HexColor("2FAE3B"),
                      headingFontSize: 20,
                      headingFontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              20.ph,
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomRichText(
                  title: controller.averageInflation.value,
                  titleTextColor: HexColor("2FAE3B"),
                  titleFontSIze: 16,
                  titleFontWeight: FontWeight.w500,
                  titleFontFamily: true,
                  needAnotherFontFamily: true,
                  heading: "The average inflation rate is :",
                  headingTextColor: HexColor("1E1E1E"),
                  headingFontSize: 16,
                  headingFontWeight: FontWeight.w500,
                  fontFamily: true,
                ),
              ),
              5.ph,
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomRichText(
                  title: controller.cumulativeInflation.value,
                  titleTextColor: HexColor("2FAE3B"),
                  titleFontSIze: 16,
                  titleFontWeight: FontWeight.w500,
                  titleFontFamily: true,
                  needAnotherFontFamily: true,
                  heading: "Cumulative inflation :",
                  headingTextColor: HexColor("1E1E1E"),
                  headingFontSize: 16,
                  headingFontWeight: FontWeight.w500,
                  fontFamily: true,
                ),
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: CustomText(
                  text: controller.info.value,
                  fontSize: 14,
                  textColor: HexColor("787777"),
                ),
              ),
              50.ph,
              // adController.getNativeAdWidget(),
            ],
          )),
        ));
  }
}
