import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/margin_calculator/margin_calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';

class MarginCalculatorResultScreen extends StatelessWidget {
   MarginCalculatorResultScreen({super.key});
var controller = Get.find<MarginCalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FAFAFA"),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                elevation: 0.4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
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
                    Divider(
                      thickness: 0.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Profit:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.black,
                        richTextValue: '${controller.profit.toStringAsFixed(2)}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey.withOpacity(0.2),
                    ),
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
            ),
            CommonPieChartWidget(
              list: controller.list,
              total: controller.total.value,
              netPriceColor: "FF9466",
              taxAmountColor: "0F182E",
              netTitle: "Cost",
              taxTitle: "Profit Margin",
            ),
          ],
        ),
      ),),
    );
  }
}
