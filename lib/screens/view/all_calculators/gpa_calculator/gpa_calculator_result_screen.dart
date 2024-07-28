import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/gpa_calculator/gpa_controller.dart';
import 'package:calculation_app/screens/widgets/custom_text/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';

class GPACalculatorResultScreen extends StatelessWidget {
  GPACalculatorResultScreen({super.key});
  var controller = Get.find<GPAController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "CD Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Result", gradiantColorNeed: true,),
            20.ph,
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              color: HexColor("244384"),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomText(
                          text: "GPA: ",
                          textColor: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      CustomText(
                        text: (controller.overallGPA.value /
                                controller.totalCreditWithoutPNP.value)
                            .toStringAsFixed(2),
                        textColor: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomText(
                          text: "Total Credit : ",
                          textColor: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      CustomText(
                        text: "${controller.totalCredit.value}",
                        textColor: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            30.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    color: HexColor("244384"),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: CustomText(
                              text: "Course",
                              textColor: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: CustomText(
                              text: "Credit",
                              textColor: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: CustomText(
                              text: "Grade",
                              textColor: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            )),
                          ),
                          Expanded(
                            child: Center(
                                child: CustomText(
                              text: "Grade Point",
                              textColor: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.courseControllers.length,
                      itemBuilder: (_, index) {
                        return Table(
                          defaultColumnWidth: const FixedColumnWidth(20),
                          border: TableBorder.all(
                              width: 1.0, color: HexColor("F3F3F3")),
                          children: [
                            TableRow(children: [
                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: CustomText(
                                  text:
                                      controller.courseControllers[index].text,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              )),
                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: CustomText(
                                  text: controller
                                      .instructorControllers[index].text,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              )),
                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: CustomText(
                                  text: controller.selectedGrades[index],
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              )),
                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: CustomText(
                                  text: (controller.selectedGrades[index] ==
                                              "P") ||
                                          (controller.selectedGrades[index] ==
                                              "NP")
                                      ? "Not Counted"
                                      : "${controller.instructorControllers[index].text} * ${controller.returnValue(controller.selectedGrades[index])} = ${(controller.returnValue(controller.selectedGrades[index]) * int.parse(controller.instructorControllers[index].text)).toStringAsFixed(1)}",
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              )),
                            ]),
                          ],
                        );
                        // return Column(
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Expanded(
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(left: 0.5),
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 30,
                        //                   width: 0.9,
                        //                   color: Colors.black,
                        //                 ),
                        //                  Expanded(
                        //                   child: Center(
                        //                       child: CustomText(
                        //                     text: controller.courseControllers[index].text,
                        //                     textColor: Colors.black,
                        //                     fontWeight: FontWeight.normal,
                        //                     fontSize: 14,
                        //                   )),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(left: 1),
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 30,
                        //                   width: 0.9,
                        //                   color: Colors.black,
                        //                 ),
                        //                  Expanded(
                        //                   child: Center(
                        //                       child: CustomText(
                        //                     text: controller.instructorControllers[index].text,
                        //                     textColor: Colors.black,
                        //                     fontWeight: FontWeight.normal,
                        //                     fontSize: 14,
                        //                   )),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(left: 1),
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 30,
                        //                   width: 0.9,
                        //                   color: Colors.black,
                        //                 ),
                        //                  Expanded(
                        //                   child: Center(
                        //                       child: CustomText(
                        //                     text: controller.selectedGrades[index],
                        //                     textColor: Colors.black,
                        //                     fontWeight: FontWeight.normal,
                        //                     fontSize: 14,
                        //                   )),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(left: 1),
                        //             child: Row(
                        //               children: [
                        //                 Container(
                        //                   height: 30,
                        //                   width: 0.9,
                        //                   color: Colors.black,
                        //                 ),
                        //                  Expanded(
                        //                   child: Center(
                        //                       child: CustomText(
                        //                     text: "${controller.instructorControllers[index].text} * ${controller.returnValue(controller.selectedGrades[index])} = ${(controller.returnValue(controller.selectedGrades[index]) * int.parse(controller.instructorControllers[index].text)).toStringAsFixed(1)}",
                        //                     textColor: Colors.black,
                        //                     fontWeight: FontWeight.normal,
                        //                     fontSize: 14,
                        //                   )),
                        //                 ),
                        //                 Padding(
                        //                   padding:
                        //                       const EdgeInsets.only(right: 0.7),
                        //                   child: Container(
                        //                     height: 30,
                        //                     width: 0.9,
                        //                     color: Colors.black,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(horizontal: 0.8),
                        //       child: Container(
                        //         height: 1,
                        //         width: MediaQuery.of(context).size.width,
                        //         color: Colors.black,
                        //       ),
                        //     )
                        //   ],
                        // );
                      }),
                  20.ph,
                  Container(
                      height: 32,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: HexColor("FAFAFA")),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: CustomText(
                          text: "Total Credit: ${controller.totalCredit.value}",
                          textAlign: TextAlign.start,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                  10.ph,
                  Container(
                      height: 32,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: HexColor("FAFAFA")),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: CustomText(
                          text:
                              "Overall GPA: ${(controller.overallGPA.value / controller.totalCreditWithoutPNP.value).toStringAsFixed(1)}",
                          textAlign: TextAlign.start,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
