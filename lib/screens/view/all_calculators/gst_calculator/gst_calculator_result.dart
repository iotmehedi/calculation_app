import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/gst_calculator/gst_calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';

class GSTCalculatorResultScreen extends StatelessWidget {
   GSTCalculatorResultScreen({super.key});
var controller = Get.find<GSTCalculatorController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "CD Calculator",
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
                        title: "GST Total:",
                        titleFontWeight: FontWeight.w500,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.black,
                        richTextValue:
                        '${controller.gstTotal.round()}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(
                      thickness: 0.4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: controller.radioButtonStatus.value == "1" ? "Post-GST Amount:" : "Pre - GST Amount",
                        titleFontWeight: FontWeight.w500,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.black,
                        richTextValue:
                        '${controller.postGstAmount.round()}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),

                    10.ph,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
