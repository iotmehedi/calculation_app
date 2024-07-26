import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/ppf-calculator/ppf_calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_custom_richText/common_custom_richText.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';


class PPFCalculatorScreen extends StatelessWidget {
  PPFCalculatorScreen({super.key});

  var controller = Get.put(PPFCalculatorController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "PPF Calculator"),
        body: Obx(()=> Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey.value,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  20.ph,
                        CommonTextFieldCustom(
                          headingName: 'Yearly Investment',
                          controller: controller.investmentController.value,
                          keyboardType: TextInputType.number,
                          hint: "₹",
                          headingFontSize: 16,
                          headingFontWeight: FontWeight.w400,
                          headingTextColor: HexColor("8E8E8E"),
                          needPadding: true,
                          onlyNeedSuffix: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your yearly investment';
                            }
                            return null;
                          },
                        ),
              
                  10.ph,
                  CommonRichTextFieldCustom(
                    titleName: "(in Year)",
                    titleTextColor: Colors.blue,
                    titleFontSIze: 14.0,
                    headingFontSize: 16.0,
                    titleFontWeight: FontWeight.w400,
                    headingFontWeight: FontWeight.w400,
                    headingName: 'Long Tenure ',
                    headingTextColor: Colors.black,
                    controller: controller.tenureController.value,
                    keyboardType: TextInputType.number,
                    needPadding: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter long tenure';
                      }
                      return null;
                    },
                  ),
                  10.ph,
                  CommonTextFieldCustom(
                    headingName: 'YRate of Interest',
                    controller: controller.interestRateController.value,
                    keyboardType: TextInputType.number,
                    needPadding: true,
                    onlyNeedSuffix: false,
                    suffixIcon: Icon(Icons.percent, size: 14,),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the rate of interest';
                      }
                      return null;
                    },
                  ),
              
                  SizedBox(height: 20),
                  CustomCalculateClearWidget(
                    onPressCalculate: () {
                      if (controller.formKey.value.currentState!
                          .validate()) {
                        controller.calculatePPF();
                      }
                    },
                    onPressClear: controller.allFieldClear,
                    clearButtonTextColor: HexColor("244384"),
                    clearButtonFontWeight: FontWeight.w500,
                    clearButtonTitleFontSize: 20,
                  ),
                  SizedBox(height: 20),
                  
                ],
              ),
            ),
          ),
        ),)
    );
  }
}
