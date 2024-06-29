import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/ppf-calculator/ppf_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';

class PPFCalculatorResult extends StatelessWidget {
   PPFCalculatorResult({super.key});
  var controller = Get.find<PPFCalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "PPF Calculator"),
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
                    children: [
                      CustomRow(title: "Investment Amount:", value: "\$ ${controller.investedAmount.round()}", titleFontWeight: FontWeight.normal, headingFontWeight: FontWeight.normal),
                      10.ph,
                      CustomRow(title: "Total Interest:", value: "\$ ${controller.totalInterest.round()}", titleFontWeight: FontWeight.normal, headingFontWeight: FontWeight.normal),
                      const Divider(
                        thickness: 0.5,
                      ),
                      CustomRow(title: "Maturity Value:", value: "\$ ${controller.maturityValue.round()}", titleFontWeight: FontWeight.normal, headingFontWeight: FontWeight.normal, titleColor: Colors.blue, headingColor: Colors.blue),
                      20.ph,
                    ],
                  ),
                ),
              ),
            ),
            10.ph,
            CommonPieChartWidget(list: controller.list, total: controller.total.value, netPriceColor: "458EEC", taxAmountColor: "99CBF7", netTitle: "Total Investment", taxTitle: "Total Interest"),
          ],
        ),
      ),
    );
  }
  Widget CustomRow({required String title, required String value, FontWeight? titleFontWeight, FontWeight? headingFontWeight, Color? titleColor, Color? headingColor}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: globalText16(text: title, fontWeight: titleFontWeight ?? FontWeight.w500, color: titleColor, textAlign: TextAlign.start)),
          Expanded(
              child: globalText16(
                  text: value,
                  alignment: Alignment.centerLeft,
                  fontWeight: headingFontWeight ?? FontWeight.w700, color: headingColor)),
        ],
      ),
    );
  }

}
