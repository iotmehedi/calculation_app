import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/vat_calculator/vat_controller.dart';
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

class VatResultScreen extends StatelessWidget {
  VatResultScreen({super.key});
  var controller = Get.find<VatController>();
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "VAT Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    //   bottomNavigationBar: Column(
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
            const CommonResultHeading(headingName: "Calculation"),
            20.ph,
            Padding(
              padding: const EdgeInsets.symmetric( vertical: 10),
              child: ContainerShadowWidget(
                widget: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Gross Price:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${NumberFormat('#,##,##0.00', 'en_US')
                            .format(controller.grossPrice.round())}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      thickness: 0.4,
                      color: HexColor("FAFAFA"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "TAX Amount:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${controller.taxAmount.round()}',
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
              netTitle: "Net Price",
              taxTitle: "Tax Amount",
            ),
          ],
        ),
      ),
    );
  }
}
