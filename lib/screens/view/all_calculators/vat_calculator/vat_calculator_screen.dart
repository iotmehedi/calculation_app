import 'package:calculation_app/screens/view/all_calculators/vat_calculator/vat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';


class VATCalculatorHomePage extends StatefulWidget {
  @override
  _VATCalculatorHomePageState createState() => _VATCalculatorHomePageState();
}

class _VATCalculatorHomePageState extends State<VATCalculatorHomePage> {
var controller = Get.put(VatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "VAT Calculator",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey.value,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextFieldCustom(
                  headingName: 'VAT Rate ',
                  titleName: "(%)",
                  headingFontSize: 16,
                  titleFontSize: 14,
                  headingTextColor: Colors.black,
                  headingFontWeight: FontWeight.w400,
                  controller: controller.vatRateController.value,
                  keyboardType: TextInputType.number,
                  needPadding: true,
                  onlyNeedSuffix: true,
                  suffixIcon: Icon(
                    Icons.percent,
                    size: 16,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter vat rate';
                    }
                    return null;
                  },
                ),
            
                SizedBox(height: 16),
                CommonTextFieldCustom(
                  headingName: 'Net Price',
                  controller: controller.netPriceController.value,
                  keyboardType: TextInputType.number,
                  needPadding: true,
                  onlyNeedSuffix: true,
                  suffixIcon: Icon(
                    Icons.attach_money,
                    size: 16,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter net price';
                    }
                    return null;
                  },
                ),
            
                SizedBox(height: 16),
                CustomCalculateClearWidget1(
                  onPressCalculate: () {
                    if (controller.formKey.value.currentState!
                        .validate()) {
                      controller.calculateVAT();
                    }
                  },
                  onPressClear: controller.allFieldClear,
                ),
                SizedBox(height: 16),
                
              ],
            ),
          ),
        ),
      )),
    );
  }


}
