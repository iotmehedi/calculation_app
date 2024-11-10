import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/cd_calculator/cd_calculator_controller.dart';
import 'package:calculation_app/screens/view/all_calculators/discount_calculator/discount_controller.dart';
import 'package:calculation_app/screens/view/all_calculators/vat_calculator/vat_controller.dart';
import 'package:calculation_app/screens/widgets/custom_divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_pie_chart/common_pie_chart_widget.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';
import '../brm_calculator/brm_result_screen.dart';

class CDResultScreen extends StatelessWidget {
  CDResultScreen({super.key});
  var controller = Get.find<CDCalculatorController>();
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    // Get.find<AdService>().loadBannerAd();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "CD Calculator",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation", gradiantColorNeed: true),
            20.ph,
            ContainerShadowWidget(
              widget: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      textAlignMostRight: false,
                      title: "Total interest:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.black,
                      richTextValue:
                          '${NumberFormat('#,##,##0.00', 'en_US')
                              .format(controller.totalInterest.value)}',
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      textAlignMostRight: false,
                      title: "Total tax:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.black,
                      richTextValue:
                          '${NumberFormat('#,##,##0.00', 'en_US')
                              .format(controller.totalTax.value)}',
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      textAlignMostRight: false,
                      title: "Interest after tax:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.black,
                      richTextValue:
                          '${NumberFormat('#,##,##0.00', 'en_US')
                              .format(controller.interestAfterTax.value)}',
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomDivider(),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                    child: CustomRowWithRichtext(
                      textAlignMostRight: false,
                      title: "End Balance:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.w600,
                      titleFontSIze: 16,
                      headingColor: HexColor("437AFF"),
                      titleColor: HexColor("437AFF"),
                      richTextTitle: '\$',
                      richtextTitleColor: HexColor("437AFF"),
                      richTextValue:
                      NumberFormat('#,##,##0.00', 'en_US')
                          .format((controller.interestAfterTax.value ?? 0.0) + (double.tryParse(controller.initialDepositController.value.text ?? '') ?? 0.0)),

                      richTextValueFontWeight: FontWeight.w500,
                      richTextValueColor: HexColor("437AFF"),

                    ),
                  ),
                ],
              ),
            ),
            20.ph,
            CommonThreePieChartWidget(
              list: controller.list,
              total: controller.total.value,
              netPriceColor: "458EEC",
              taxAmountColor: "99CBF7",
              netTitle: "Initial deposit",
              taxTitle: "Interest After Tax",
              lastTitle: "Tax",
              lastColor: "2B2E63",
            ),
          ],
        ),
      ),
    );
  }
}
