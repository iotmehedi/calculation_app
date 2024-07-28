import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/grade_calculator/grade_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';

class GradeResultScreen extends StatelessWidget {
  GradeResultScreen({super.key});
  var controller = Get.find<GradeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Grade Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CommonResultHeading(headingName: "Results", gradiantColorNeed: true,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.ph,
                  Visibility(
                    visible: controller.selectedButton.value == true &&
                        controller.radioButtonStatus.value == "1"
                        ? true
                        : false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        globalText16(
                            text: "Average grade", fontWeight: FontWeight.bold),
                        5.ph,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ContainerShadowWidget(
                            margin: 0,
                            widget: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  globalText20(
                                      text: controller.averageGrade.value
                                          .toStringAsFixed(2)
                                          .toString(),
                                      color: HexColor("244384"),
                                      fontWeight: FontWeight.bold),
                                  Divider(
                                    thickness: 1,
                                    color: HexColor("FAFAFA"),
                                  ),
                                  globalText20(
                                      text:
                                      "Grade : ${controller.averageLetterGrade.value.toString()}",
                                      color: HexColor("244384"),
                                      fontWeight: FontWeight.bold),
                                ],
                              ),
                            ),
                          ),
                        ),
                        10.ph,
                        globalText16(
                            text: "Grade Calculation",
                            fontWeight: FontWeight.bold),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ContainerShadowWidget(
                            margin: 0,
                            widget: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 5, top: 15, bottom: 8),
                              child: CustomText(
                                text: controller.averageCalculation.value,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        10.ph,
                        globalText16(
                            text: "Additional grade needed",
                            fontWeight: FontWeight.bold),
                        5.ph,
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ContainerShadowWidget(
                            margin: 0,
                            widget: Padding(
                              padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8,right: 8),
                              child: Column(
                                children: [
                                  10.ph,
                                  globalText20(
                                      text: controller.additionalGrade.value
                                          .toStringAsFixed(2)
                                          .toString(),
                                      color: HexColor("244384"),
                                      fontWeight: FontWeight.bold),
                                  5.ph,
                                  Divider(
                                    thickness: 1,
                                    color: HexColor("FAFAFA"),
                                  ),
                                  5.ph,
                                  globalText20(
                                      text:
                                      "Grade : ${controller.additionalLetterGrade.value.toString()}",
                                      color: HexColor("244384"),
                                      fontWeight: FontWeight.bold),
                                  10.ph,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: controller.selectedButton.value == true &&
                        controller.radioButtonStatus.value == "2"
                        ? true
                        : false,
                    child: ContainerShadowWidget(
                      margin: 0,
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 15, bottom: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "GPA: ",
                                    textColor: HexColor("244384"),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                                CustomText(
                                  text: (controller.overallGPA.value /
                                      controller
                                          .totalCreditWithoutPNP.value)
                                      .toStringAsFixed(2),
                                  textColor: HexColor("244384"),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: HexColor("FAFAFA"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "Grade : ",
                                    textColor: HexColor("244384"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                CustomText(
                                  text:
                                  "${controller.letter((controller.overallGPA.value / controller.totalCreditWithoutPNP.value))}",
                                  textColor: HexColor("244384"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ),
                          10.ph,
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                    controller.selectedButton.value == false ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          globalText16(
                              text:
                              "Final exam grade needed to get the target grade",
                              fontWeight: FontWeight.w500,
                              textAlign: TextAlign.start),
                          20.ph,
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                                      color: HexColor("FFFFFF"),
                                  border: Border.all(color: HexColor("F3F6F9"))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: globalText16(
                                        text: controller.result.value,
                                        fontWeight: FontWeight.w500,
                                        textAlign: TextAlign.start),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                                        color: HexColor("244384")
                                    ),
                                    child: Center(
                                      child: globalText16(text: "%", color: Colors.white, textAlign: TextAlign.center, alignment: Alignment.center),
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
