import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/discount_calculator/discount_controller.dart';
import 'package:calculation_app/screens/view/all_calculators/vat_calculator/vat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';
import '../brm_calculator/brm_result_screen.dart';

class DiscountResultScreen extends StatelessWidget {
  DiscountResultScreen({super.key});
  var controller = Get.find<DiscountController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Discount Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
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
                        title: "Payable Amount:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${controller.payableAmount.toStringAsFixed(2)}',
                        richTextValueFontWeight: FontWeight.w500,

                      ),
                    ),
                    Divider(thickness: 0.4,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Discount:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${controller.discountAmount.toStringAsFixed(2)}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(thickness: 0.5, color: Colors.grey.withOpacity(0.2),),

                    10.ph,
                  ],
                ),
              ),
            ),
            CommonPieChartWidget(list: controller.list, total: controller.total.value, netPriceColor: "FF9466", taxAmountColor: "66D1FF", netTitle: "Payable Amount", taxTitle: "Discount"),
          ],
        ),
      ),
    );
  }
}
