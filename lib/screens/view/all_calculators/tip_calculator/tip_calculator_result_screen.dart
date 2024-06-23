import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/tip_calculator/tip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_result_heading/common_result_heading.dart';
import '../../../widgets/custom_row_with_richtext/custom_row_with_richtext.dart';
import '../brm_calculator/brm_result_screen.dart';

class TipCalculatorResultScreen extends StatelessWidget {
  TipCalculatorResultScreen({super.key});
  var controller = Get.find<TipController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("FAFAFA"),
      appBar: CustomAppBar(
        title: "Tip Calculator",
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
                          title: "Tip:",
                          titleFontWeight: FontWeight.w600,
                          headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${controller.tipAmount.toStringAsFixed(2)}',
                      richTextValueFontWeight: FontWeight.w500,

                      ),
                    ),
                    Divider(thickness: 0.4,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Total Amount:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${controller.totalAmount.toStringAsFixed(2)}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(thickness: 0.5, color: Colors.grey.withOpacity(0.2),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Tip per person:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${controller.tipPerPerson.toStringAsFixed(2)}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(thickness: 0.5, color: Colors.grey,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomRowWithRichtext(
                        title: "Total per person:",
                        titleFontWeight: FontWeight.w600,
                        headingFontWeight: FontWeight.normal,
                        richTextTitle: '\$',
                        richtextTitleColor: Colors.blue,
                        richTextValue: '${controller.totalPerPerson.toStringAsFixed(2)}',
                        richTextValueFontWeight: FontWeight.w500,
                      ),
                    ),
                    10.ph,
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
