import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/tip_calculator/tip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import '../../../widgets/custom_divider/custom_divider.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';
import '../brm_calculator/brm_result_screen.dart';

class TipCalculatorResultScreen extends StatelessWidget {
  TipCalculatorResultScreen({super.key});
  var controller = Get.find<TipController>();
  // var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Tip Calculator",
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
                      textAlignMostRight: false,
                        title: "Tip:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.blue,
                      richTextValue: '${NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.tipAmount.value)}',
                    richTextValueFontWeight: FontWeight.w500,

                    ),
                  ),
                  CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      textAlignMostRight: false,
                      title: "Total Amount:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.blue,
                      richTextValue: '${NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.totalAmount.value)}',
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      textAlignMostRight: false,
                      title: "Tip per person:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.blue,
                      richTextValue: '${NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.tipPerPerson.value)}',
                      richTextValueFontWeight: FontWeight.w500,
                    ),
                  ),
                  CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      textAlignMostRight: false,
                      title: "Total per person:",
                      titleFontWeight: FontWeight.w600,
                      headingFontWeight: FontWeight.normal,
                      titleColor: HexColor("437AFF"),
                      richTextTitle: '\$',
                      richtextTitleColor: Colors.blue,
                      richTextValue: '${NumberFormat('#,##,##0.00', 'en_US')
                          .format(controller.totalPerPerson.value)}',
                      richTextValueFontWeight: FontWeight.w500,
                      richTextValueColor: HexColor("437AFF"),
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
