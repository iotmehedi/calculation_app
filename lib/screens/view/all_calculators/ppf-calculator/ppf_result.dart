import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/ppf-calculator/ppf_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/textstyle.dart';
import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';

class PPFCalculatorResult extends StatelessWidget {
   PPFCalculatorResult({super.key});
  var controller = Get.find<PPFCalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar:  CustomAppBar(title: "PPF Calculator", onBackPressed: (){
        Navigator.pop(context);
      },),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation", gradiantColorNeed: true,),
            20.ph,
            ContainerShadowWidget(
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomRow(title: "Investment Amount:", value: "₹ ${NumberFormat('#,##,##', 'en_US')
                    .format(controller.investedAmount.value.round())}", titleFontWeight: FontWeight.w400, headingFontWeight: FontWeight.w500, titleColor: AppColors.deepGray1),
                    10.ph,
                    CustomRow(title: "Total Interest:", value: "₹ ${NumberFormat('#,##,##', 'en_US')
                        .format(controller.totalInterest.round())}", titleFontWeight: FontWeight.w400, headingFontWeight: FontWeight.w500, titleColor: AppColors.deepGray1),
                    CustomDivider(),
                    CustomRow(title: "Maturity Value:", value: "₹ ${NumberFormat('#,##,##', 'en_US')
                        .format(controller.maturityValue.round())}", titleFontWeight: FontWeight.w500, headingFontWeight: FontWeight.w500, titleColor: AppColors.blue, headingColor: Colors.blue),
                    10.ph,
                  ],
                ),
              ),
            ),
            10.ph,
            CommonPieChartWidget(list: controller.list, total: controller.total.value, netPriceColor: "458EEC", taxAmountColor: "99CBF7", netTitle: "Total Investment", taxTitle: "Total Interest", badgeWidgetVisibleOrNot: true,),
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
              flex: 2,
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
