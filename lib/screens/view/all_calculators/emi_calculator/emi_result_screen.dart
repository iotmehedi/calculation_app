import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/consts/common_method.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/emi_calculator/emi_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_text/custom_text.dart';
import '../brm_calculator/brm_result_screen.dart';

class EMIResultScreen extends StatelessWidget {
  EMIResultScreen({super.key});
  var controller = Get.find<EMIController>();
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "EMI Calculator", onBackPressed: (){
        Navigator.pop(context);
      },),
      // bottomNavigationBar: adController.getBannerAdWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation"),
            20.ph,
            CustomResultMonthly(
              title:
              NumberFormat('#,##,##0.00', 'en_US').format(controller.monthlyEmi.value),
              heading: "Monthly EMI:",
              headingColor: Colors.green,
              titleColor: Colors.white,
            ),
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
                              "₹ ${NumberFormat('#,##,##0.00', 'en_US').format(double.tryParse(controller.loanAmountController.value.text)).replaceAll(".00", '')}",
                          titleFontWeight: FontWeight.normal,
                      headingColor: AppColors.yellowType,
                        headingFontWeight: FontWeight.normal,
                      ),
                      10.ph,
                      CustomRow(
                          title: "Total Interest Payable:",
                          value: "₹ ${NumberFormat('#,##,##0.00', 'en_US').format(controller.totalInterest.round()).replaceAll(".00", '')}",
                          titleFontWeight: FontWeight.normal,
                          headingFontWeight: FontWeight.normal,
                      headingColor: AppColors.black
                      ),
                      10.ph,
                      Divider(
                        thickness: 0.5,
                      ),
                    globalText16(text: "Total Payable Amount", fontWeight: FontWeight.w600, color: AppColors.deepBlue, textAlign: TextAlign.center, alignment: Alignment.center, fontSize: 16),
                    globalText16(text: "₹ ${NumberFormat('#,##,##0.00', 'en_US').format(controller.totalPayment.round()).replaceAll(".00", '')}", fontWeight: FontWeight.w600, color: AppColors.black, textAlign: TextAlign.center, alignment: Alignment.center, fontSize: 16),

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
                            10.ph,
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
