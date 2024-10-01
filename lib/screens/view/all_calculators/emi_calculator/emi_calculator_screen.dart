import 'dart:math';

import 'package:calculation_app/core/utils/consts/textstyle.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/emi_calculator/emi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_custom_richText/common_custom_richText.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';

class EmiCalculator extends StatefulWidget {
  @override
  _EmiCalculatorState createState() => _EmiCalculatorState();
}

class _EmiCalculatorState extends State<EmiCalculator> {
  var controller = Get.put(EMIController());
  var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(title: "EMI Calculator", onBackPressed: (){
        Navigator.pop(context);
        controller.allFieldClear();
      },),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey.value,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonTextFieldCustom(
                      headingName: 'Loan Amount',
                      controller: controller.loanAmountController.value,
                      keyboardType: TextInputType.number,
                      needPadding: true,
                      suffixIcon: Icon(
                        Icons.currency_rupee,
                        size: 16,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter loan amount';
                        }
                        return null;
                      },
                    ),
                    10.ph,
                    CommonRichTextFieldCustom(
                      headingName: 'Rate of ',
                      controller: controller.interestRateController.value,
                      keyboardType: TextInputType.number,
                      needPadding: true,
                      suffixIcon: Icon(
                        Icons.percent,
                        size: 16,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Rate of Interest';
                        }
                        return null;
                      },
                      titleName: '(%)',
                      titleTextColor: Colors.blue,
                      headingTextColor: Colors.black,
                      titleFontWeight: FontWeight.normal,
                      headingFontWeight: FontWeight.normal,
                    ),
                    10.ph,
                    CommonRichTextFieldCustom(
                      headingName: 'Long Tenure ',
                      controller: controller.loanTenureController.value,
                      keyboardType: TextInputType.number,
                      needPadding: false,
                      prefixIcon: Icon(
                        Icons.percent,
                        size: 16,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter long tenure';
                        }
                        return null;
                      },
                      titleName: '(Year)',
                      titleTextColor: Colors.blue,
                      headingTextColor: Colors.black,
                      titleFontWeight: FontWeight.normal,
                      headingFontWeight: FontWeight.normal,
                    ),
                    20.ph,
                    CustomCalculateClearWidget1(
                      onPressCalculate: () {
                        if (controller.formKey.value.currentState!.validate()) {
                          controller.calculateEmi();
                        }
                      },
                      onPressClear: controller.allFieldClear,
                      clearButtonTitleFontSize: 20,
                      clearButtonFontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 80),
                    adController.getNativeAdWidget(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
