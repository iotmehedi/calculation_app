import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
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

class DiscountResultScreen extends StatelessWidget {
  DiscountResultScreen({super.key});
  var controller = Get.find<DiscountController>();
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Discount Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      // bottomNavigationBar: adController.getBannerAdWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonResultHeading(headingName: "Calculation"),
            20.ph,
            ContainerShadowWidget(
              widget: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    10.ph,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Payable Amount:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue:
                            '${NumberFormat('#,##,##0.00', 'en_US').format(controller.payableAmount.value)}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomDivider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Discount:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue:
                            '${NumberFormat('#,##,##0.00', 'en_US').format(controller.discountAmount.value)}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    10.ph,
                  ],
                ),
              ),
            ),
            20.ph,
            CommonPieChartWidget(
                list: controller.list,
                total: controller.total.value,
                netPriceColor: "FF9466",
                taxAmountColor: "66D1FF",
                netTitle: "Payable Amount",
                taxTitle: "Discount",
                badgeWidgetVisibleOrNot: true),
            60.ph,
            // adController.getNativeAdWidget(),
          ],
        ),
      ),
    );
  }
}
