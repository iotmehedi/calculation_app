import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/loan_calculator/loan_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/show_result_title/show_result_value.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_richtext/custom_richtext.dart';
import '../../../widgets/custom_text/custom_text.dart';
import '../../../widgets/custom_two_row_widget/custom_row_widget.dart';

class LoanCalculatorResult extends StatelessWidget {
  LoanCalculatorResult({super.key});
  var controller = Get.find<LoanCalcualtorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Loan Calculator',
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Result"),
            20.ph,
            ShowResultValue(value: NumberFormat('#,##,##0.00', 'en_US')
                .format(double.parse(controller.monthlyPayment.value.toStringAsFixed(2))), title: "Payback Payment:  "),
            20.ph,
            ContainerShadowWidget(
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    CustomHalfRow(
                      title:
                          "Total of Payments",
                      value:
                          '\$${NumberFormat('#,##,##0.00', 'en_US')
                              .format(double.tryParse(controller.totalPayments.value.toStringAsFixed(2)))}',
                      headingColor: HexColor("8E8E8E"),
                      valueColor: HexColor("101010"),
                    ),
                    10.ph,
                    CustomHalfRow(
                      title: "Total Interest",
                      value:
                          '\$${NumberFormat('#,##,##0.00', 'en_US')
                              .format(double.tryParse(controller.totalInterest.value.toStringAsFixed(2)))}',
                      headingColor: HexColor("8E8E8E"),
                      valueColor: HexColor("101010"),
                    ),
                    10.ph,
                  ],
                ),
              ),
            ),
            20.ph,
            ContainerShadowWidget(
              widget: SizedBox(
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
                                  sections: controller.showingSections(),
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
                            CustomRow(
                                color: HexColor("458EEC"), text: "Principal"),
                            CustomRow(
                                color: HexColor("99CBF7"), text: "Interest"),
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
  Widget CustomRow({required Color color, required String text}) {
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
