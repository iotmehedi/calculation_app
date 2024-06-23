import 'package:calculation_app/core/utils/consts/common_method.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/emi_calculator/emi_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_text/custom_text.dart';
import '../brm_calculator/brm_result_screen.dart';

class EMIResultScreen extends StatelessWidget {
  EMIResultScreen({super.key});
  var controller = Get.find<EMIController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FAFAFA"),
      appBar: CustomAppBar(title: "EMI Calculator"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation"),
            20.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomRow(
                          title: "Loan Amount:",
                          value:
                              "\$ ${controller.loanAmountController.value.text}",
                          titleFontWeight: FontWeight.normal,
                          headingFontWeight: FontWeight.normal),
                      10.ph,
                      CustomRow(
                          title: "Total Interest Payable:",
                          value: "\$ ${controller.totalInterest.round()}",
                          titleFontWeight: FontWeight.normal,
                          headingFontWeight: FontWeight.normal),
                      10.ph,
                      Divider(
                        thickness: 0.5,
                      ),
                      Center(
                          child: CustomRow(
                              title: "Total Payable Amount:",
                              value: "\$ ${controller.totalPayment.round()}",
                              titleFontWeight: FontWeight.normal,
                              headingFontWeight: FontWeight.normal,
                              titleColor: Colors.blue,
                              headingColor: Colors.blue)),
                    ],
                  ),
                ),
              ),
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 150,
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 140,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: PieChart(
                                PieChartData(
                                  sections: CommonMethod().showingSections(
                                      list: controller.list,
                                      total: controller.total.value,
                                      principalColor: "FF9466",
                                      interestColor: "0F182E"),
                                  borderData: FlBorderData(
                                    show: true,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomRoww(
                                color: HexColor("FF9466"), text: "Loan Amount"),
                            CustomRoww(
                                color: HexColor("0F182E"),
                                text: "Total Interest"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CustomRoww({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: color),
        ),
        5.pw,
        CustomText(
          text: text,
          fontSize: 14,
        ),
      ],
    );
  }
}
