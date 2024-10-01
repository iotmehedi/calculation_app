import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/time_calculator/time_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/container_shadow_widget/container_shadow_widget.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/services/ad_services.dart';

class TimeCalculatorResultPage extends StatelessWidget {
  TimeCalculatorResultPage({super.key});
  var controller = Get.find<TimeCalculatorController>();
  var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          appBar: CustomAppBar(
            title: "Time Calculator",
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: adController.getNativeAdWidget(),
          ),
          10.ph,
          adController.getBannerAdWidget(),
        ],
      ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ContainerShadowWidget(
                  widget: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        globalText16(
                            text: "Answer:", fontWeight: FontWeight.w600),
                        10.ph,
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: globalText14(
                            text:
                                "${controller.days.value} days ${controller.hours.value} hours ${controller.minutes.value} minutes ${controller.seconds.value} seconds",
                            fontWeight: FontWeight.w400,
                            color: HexColor("2B2E63"),
                          ),
                        ),
                        10.ph,
                        CustomDivider(),
                        10.ph,
                        globalText14(
                          text:
                              "= ${controller.totalDays.value.toStringAsFixed(5)} total days",
                          fontWeight: FontWeight.w400,
                          color: HexColor("0F182E"),
                        ),
                        5.ph,
                        globalText14(
                          text:
                              "= ${controller.totalHours.value.toStringAsFixed(5)} total hours",
                          fontWeight: FontWeight.w400,
                          color: HexColor("0F182E"),
                        ),
                        5.ph,
                        globalText14(
                          text:
                              "= ${controller.totalMinutes.value.toStringAsFixed(5)} total minutes",
                          fontWeight: FontWeight.w400,
                          color: HexColor("0F182E"),
                        ),
                        5.ph,
                        globalText14(
                          text:
                              "= ${controller.totalSeconds.value.toStringAsFixed(5)} total seconds",
                          fontWeight: FontWeight.w400,
                          color: HexColor("0F182E"),
                        ),
                        20.ph,
                        globalText14(
                          text: "Alternative Total:",
                          fontWeight: FontWeight.w600,
                          color: HexColor("0F182E"),
                        ),
                        10.ph,
                        globalText14(
                          text: controller.buildTimeString(),
                          fontWeight: FontWeight.w400,
                          color: HexColor("0F182E"),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
