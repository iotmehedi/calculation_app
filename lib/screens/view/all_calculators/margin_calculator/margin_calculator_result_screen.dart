import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/margin_calculator/margin_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/custom_divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';

class MarginCalculatorResultScreen extends StatelessWidget {
   MarginCalculatorResultScreen({super.key});
var controller = Get.find<MarginCalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Margin Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation"),
            20.ph,
            ContainerShadowWidget(
              widget: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      title: "Margin:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '',
                      richtextTitleColor: Colors.blue,
                      richTextValue: '${controller.margin.toStringAsFixed(2)} %',
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                  const CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      title: "Profit:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.black,
                      richTextValue: NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.profit.value),
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                 const CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      title: "Markup:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '',
                      richtextTitleColor: Colors.transparent,
                      richTextValue: '${controller.markup.toStringAsFixed(2)} %',
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                  10.ph,
                ],
              ),
            ),
            20.ph,
            CommonPieChartWidget(
              list: controller.list,
              total: controller.total.value,
              netPriceColor: "FF9466",
              taxAmountColor: "0F182E",
              netTitle: "Cost",
              taxTitle: "Profit Margin",
              badgeWidgetVisibleOrNot: true,
            ),
          ],
        ),
      ),),
    );
  }
}
