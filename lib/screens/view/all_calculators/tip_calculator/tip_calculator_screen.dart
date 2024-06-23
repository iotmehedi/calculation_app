import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/tip_calculator/tip_controller.dart';
import 'package:calculation_app/screens/widgets/custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  var controller = Get.put(TipController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Tip Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
                key: controller.formKey.value,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CommonTextFieldCustom(
                        headingName: 'Loan Amount',
                        controller: controller.priceController.value,
                        keyboardType: TextInputType.number,
                        needPadding: true,
                        onlyNeedSuffix: true,
                        suffixIcon: Icon(
                          Icons.attach_money,
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
                      CommonTextFieldCustom(
                        headingName: 'Tip',
                        controller: controller.tipController.value,
                        keyboardType: TextInputType.number,
                        needPadding: true,
                        onlyNeedSuffix: true,
                        suffixIcon: Icon(
                          Icons.percent,
                          size: 16,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter tip';
                          }
                          return null;
                        },
                      ),
                      10.ph,
                      CommonTextFieldCustom(
                        headingName: 'Number of people',
                        controller: controller.peopleController.value,
                        keyboardType: TextInputType.number,
                        needPadding: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter number of people';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomCalculateClearWidget(
                        onPressCalculate: () {
                          if (controller.formKey.value.currentState!
                              .validate()) {
                            controller.calculateTip();
                          }
                        },
                        onPressClear: controller.allFieldClear,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                )),
          )),
    );
  }
}
