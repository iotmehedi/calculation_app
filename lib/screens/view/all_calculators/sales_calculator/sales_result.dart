import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/sales_calculator/sales_calculator_controller.dart';
import 'package:calculation_app/screens/view/all_calculators/tip_calculator/tip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:calculation_app/screens/widgets/custom_divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';
import '../brm_calculator/brm_result_screen.dart';

class SalesCalculatorResultScreen extends StatelessWidget {
  SalesCalculatorResultScreen({super.key});
  var controller = Get.find<SalesCalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Sale Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation", gradiantColorNeed: true,),
            20.ph,
            ContainerShadowWidget(
              widget: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      title: "Before Tax Price:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.black,
                      richTextValue: NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.beforeTaxPrice.value),
                      richTextValueFontWeight: FontWeight.w500,
                      textAlignMostRight: false,
                    ),
                  ),
                  CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      title: "Total Amount:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      titleColor: HexColor("437AFF"),
                      richTextTitle: '\$',
                      richtextTitleColor: HexColor("437AFF"),
                      richTextValue: NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.salesTax.value),
                      richTextValueFontWeight: FontWeight.w500,
                      richTextValueColor: HexColor("437AFF"),
                      textAlignMostRight: false,
                    ),
                  ),
                  CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      title: "Tip per person:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.black,
                      richTextValue: NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.afterTaxPrice.value),
                      richTextValueFontWeight: FontWeight.w500,
                      textAlignMostRight: false,
                    ),
                  ),


                  10.ph,
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
