import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/margin_calculator/margin_calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../core/utils/consts/app_colors.dart';
import '../../../../core/utils/services/ad_services.dart';
import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';


class MarginCalculatorScreen extends StatefulWidget {
  @override
  _MarginCalculatorScreenState createState() => _MarginCalculatorScreenState();
}

class _MarginCalculatorScreenState extends State<MarginCalculatorScreen> {
var controller = Get.put(MarginCalculatorController());
var adController = Get.put(AdService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Margin Calculator",
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      bottomNavigationBar: adController.getBannerAdWidget(),
      body: Obx(()=>Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey.value,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                CommonTextFieldCustom(
                  headingName: 'Cost',
                  controller: controller.costController.value,
                  keyboardType: TextInputType.number,
                  needPadding: true,
                  onlyNeedSuffix: false,
                  textAlign: TextAlign.start,
                  suffixIcon: Icon(
                    Icons.attach_money,
                    size: 16,
                    color: AppColors.deepGray1,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter cost';
                    }
                    return null;
                  },
                ),
                10.ph,
                CommonTextFieldCustom(
                  headingName: 'Revenue',
                  controller: controller.revenueController.value,
                  keyboardType: TextInputType.number,
                  needPadding: true,
                  onlyNeedSuffix: false,
                  textAlign: TextAlign.start,
                  suffixIcon: Icon(
                    Icons.attach_money,
                    size: 16,
                    color: AppColors.deepGray1,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter revenue';
                    }
                    return null;
                  },
                ),
            
                SizedBox(height: 20),
                CustomCalculateClearWidget(
                  onPressCalculate: () {
                    if (controller.formKey.value.currentState!
                        .validate()) {
                      controller.calculateValues();
                    }
                  },
                  onPressClear: controller.allFieldClear,
                  clearButtonTextColor: Colors.black,
                  clearButtonFontWeight: FontWeight.w500,
                  clearButtonTitleFontSize: 20,
                ),
                SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
      )),
    );
  }
}