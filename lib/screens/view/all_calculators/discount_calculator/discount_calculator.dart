import 'package:calculation_app/screens/view/all_calculators/discount_calculator/discount_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';

class DiscountCalculatorPage extends StatefulWidget {
  @override
  _DiscountCalculatorPageState createState() => _DiscountCalculatorPageState();
}

class _DiscountCalculatorPageState extends State<DiscountCalculatorPage> {
var controller = Get.put(DiscountController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Discount Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => Form(
        key: controller.formKey.value,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CommonTextFieldCustom(
                  headingName: 'Original Price',
                  controller: controller.originalPriceController.value,
                  keyboardType: TextInputType.number,
                  needPadding: true,
                  onlyNeedSuffix: true,
                  suffixIcon: Icon(
                    Icons.attach_money_outlined,
                    size: 16,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter original price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                CommonTextFieldCustom(
                  headingName: 'Percentage Rate',
                  controller: controller.discountRateController.value,
                  keyboardType: TextInputType.number,
                  needPadding: true,
                  onlyNeedSuffix: true,
                  suffixIcon: Icon(
                    Icons.percent,
                    size: 16,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter percentage rate';
                    }
                    return null;
                  },
                ),
            
                SizedBox(height: 16.0),
                CustomCalculateClearWidget(
                  onPressCalculate: () {
                    if (controller.formKey.value.currentState?.validate() ?? false) {
                      controller.calculateDiscount();
                    }
                  },
                  onPressClear: controller.allFieldClear,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
