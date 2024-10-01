import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/gst_calculator/gst_calculator_controller.dart';
import 'package:calculation_app/screens/widgets/custom_divider/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/container_shadow_widget/container_shadow_widget.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';

class GSTCalculatorResultScreen extends StatelessWidget {
   GSTCalculatorResultScreen({super.key});
var controller = Get.find<GSTCalculatorController>();
   var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "GST Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: SingleChildScrollView(
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
                      title: "GST Total:",
                      titleFontWeight: FontWeight.w500,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '₹',
                      richtextTitleColor: AppColors.blue,
                      richTextValue:
                      '${NumberFormat('#,##,##', 'en_US')
                          .format(controller.gstTotal.round())}',
                      richTextValueFontWeight: FontWeight.w600,
                      richTextValueColor: AppColors.blue,
                      textAlignMostRight: false,
                      richtextFontFamily: true,
                      titleFontFamily: true,
                      richTextTitleFontFamily: true,
                    ),
                  ),
                  CustomDivider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomRowWithRichtext(
                      title: controller.radioButtonStatus.value == "1" ? "Post-GST Amount:" : "Pre - GST Amount",
                      titleFontWeight: FontWeight.w500,
                      headingFontWeight: FontWeight.normal,
                      richTextTitle: '₹',
                      richtextTitleColor: Colors.black,
                      richTextValue:
                      '${NumberFormat('#,##,##', 'en_US')
                          .format(controller.postGstAmount.round())}',
                      richTextValueFontWeight: FontWeight.w500,
                      textAlignMostRight: false,
                      titleFontFamily: true,
                      richtextFontFamily: true,
                      richTextTitleFontFamily: true,
                    ),
                  ),

                  10.ph,
                ],
              ),
            ),
            60.ph,
            adController.getNativeAdWidget(),
          ],
        ),
      ),
    );
  }
}
