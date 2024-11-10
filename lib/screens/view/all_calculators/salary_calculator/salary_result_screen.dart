import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/salary_calculator/salary_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';

class SalaryResultCalculator extends StatelessWidget {
  SalaryResultCalculator({super.key});
  var controller = Get.find<SalaryController>();
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Salary Calculator",
        fontFamily: "Podkova",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: adController.getNativeAdWidget(),
      //     ),
      //     10.ph,
      //     adController.getBannerAdWidget(),
      //   ],
      // ),
      body: Obx(() => SingleChildScrollView(
            child: Column(
              children: [
                const CommonResultHeading(headingName: "Calculation"),
                20.ph,
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DataTable(
                    border: TableBorder.symmetric(
                        outside:
                            BorderSide(color: HexColor("F3F3F3"), width: 1),
                        inside:
                            BorderSide(color: HexColor("F3F3F3"), width: 1)),
                    columnSpacing: 20,
                    headingRowColor:
                        MaterialStateProperty.all(HexColor("0F182E")),
                    dividerThickness: 0.00000001,
                    columns: [
                      DataColumn(label: Text('')),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: globalText10(
                                  text: 'Adjusted',
                                  color: Colors.white,
                                  alignment: Alignment.centerRight,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: globalText10(
                                  text: 'Holidays & vacation\ndays adjusted',
                                  color: Colors.white,
                                  alignment: Alignment.centerRight,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Hourly',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${controller.unAdjustedHourlySalary.value.toStringAsFixed(2)}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${(controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? controller.adjustedHourlySalary.value.toStringAsFixed(2) : controller.hourlySalary.value.toStringAsFixed(2)}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                        // divider: Divider(height: 1, color: Colors.grey),
                      ),
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Daily',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${(controller.unAdjustedDailySalary.value).toStringAsFixed(2)}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${(controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? (controller.adjustedHourlySalary.value * (controller.hoursPerWeek.value / controller.daysPerWeek.value)).toStringAsFixed(2) : controller.dailySalary.value.toStringAsFixed(2)}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Weekly',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.unAdjustedWeeklySalary.value).round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? (controller.adjustedHourlySalary.value * controller.hoursPerWeek.value).round() : controller.weeklySalary.value.round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Bi-weekly',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.unAdjustedBiweeklySalary.value).round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? (controller.adjustedHourlySalary.value * controller.hoursPerWeek.value * 2).round() : controller.biweeklySalary.value.round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Semi-monthly',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.unAdjustedSemimonthlySalary.value).round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? (controller.annualAdjustedSalary.value / 24).round() : controller.semimonthlySalary.value.round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Monthly',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.unAdjustedMonthlySalary.value).round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? (controller.annualAdjustedSalary.value / 12).round() : controller.monthlySalary.value.round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Quarterly',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.unAdjustedQuarterlySalary.value).round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? (controller.annualAdjustedSalary.value / 4).round() : controller.quarterlySalary.value.round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(globalText14(
                              text: 'Annual',
                              alignment: Alignment.center,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.unAdjustedAnnuallySalary.value).round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                          DataCell(globalText14(
                              text:
                                  '\$${NumberFormat('#,##,##0.00', 'en_US').format((controller.selectedInterval.value == "Hour" || controller.selectedInterval.value == "Day") ? (controller.annualAdjustedSalary.value).round() : controller.annualSalary.value.round())}',
                              alignment: Alignment.centerRight,
                              textAlign: TextAlign.end,
                              fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  ),
                ),
                20.ph,
              ],
            ),
          )),
    );
  }
}
