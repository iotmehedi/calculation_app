import 'package:calculation_app/core/utils/consts/app_colors.dart';
import 'package:calculation_app/core/utils/core/extensions/extensions.dart';
import 'package:calculation_app/screens/view/all_calculators/sales_calculator/sales_calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/common_textfield_custom/common_textfield_custom.dart';
import '../../../widgets/custom_appbar/custom_appbar.dart';
import '../../../widgets/custom_calculate_clear_button/custom_calculate_clear_widget.dart';
import '../../../widgets/custom_elevatedButton/custom_eleveted_button.dart';


class TaxCalculatorPage extends StatefulWidget {
  @override
  _TaxCalculatorPageState createState() => _TaxCalculatorPageState();
}

class _TaxCalculatorPageState extends State<TaxCalculatorPage> {

  var controller = Get.put(SalesCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: "Sales Calculator",
        onBackPressed: () {
          Navigator.pop(context);
          controller.allFieldClear();
        },
      ),
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey.value,
          child: Column(
            children: <Widget>[
              20.ph,
              CommonTextFieldCustom(
                headingName: 'Before Tax Price',
                controller: controller.priceController.value,
                keyboardType: TextInputType.number,
                needPadding: true,
                suffixIcon: Icon(Icons.attach_money,size: 16, color: AppColors.deepGray1,),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the before tax price';
                  }
                  return null;
                },
              ),
              10.ph,
              CommonTextFieldCustom(
                headingName: 'Sales Tax Rate',
                controller: controller.taxRateController.value,
                keyboardType: TextInputType.number,
                needPadding: true,
                onlyNeedSuffix: true,
                suffixIcon: Icon(Icons.percent, size: 16,color: AppColors.deepGray1,),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the sales tax rate';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              CustomCalculateClearWidget(
                onPressCalculate: () {
                  if (controller.formKey.value.currentState?.validate() ?? false) {
                    controller.calculateTax();
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
      )),
    );
  }
}